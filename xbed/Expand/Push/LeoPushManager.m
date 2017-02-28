//
//  LeoPushManager.m
//  xbed
//
//  Created by Leo.Chen on 16/10/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LeoPushManager.h"
#import "ClientIdRequest.h"

@implementation LeoPushManager

+ (LeoPushManager *)getInstance
{
    static LeoPushManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[LeoPushManager alloc] init];
        
    });
    
    return instance;
}


+ (BOOL)registerApp
{
    [GeTuiSdk startSdkWithAppId:GeTuiAppID appKey:GeTuiAppKey appSecret:GeTuiAppSecret delegate:[LeoPushManager getInstance]];
    
    return YES;
}
+ (void)registerRemoteNotification
{
    if (iOS_Version>=8.0)
    {
        UIUserNotificationType types = (UIUserNotificationTypeAlert |
                                        UIUserNotificationTypeSound |
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }
}
+ (void)registerDeviceToken:(NSString *)deviceToken
{
    [GeTuiSdk registerDeviceToken:deviceToken];
}



#pragma mark - GeTuiSdkDelegate
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId
{
    //Upload clientId to my server ...
    NSLog(@"clientId=%@", clientId);
    
    [[RACSignal combineLatest:@[RACObserve([DBManager getInstance], isLogin), RACObserve([DBManager getInstance], token)] reduce:^id(NSNumber *isLogin, NSString *token){
        
        return @(isLogin.boolValue && token.length);
        
    }] subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            ClientIdRequestModel *model = [[ClientIdRequestModel alloc] init];
            model.clientId = clientId;
            ClientIdRequest *request = [[ClientIdRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                NSLog(@"上传clientId成功");
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                NSLog(@"上传clientId失败");
                
            }];
        }
        
    }];
}
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId
{
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
    
    NSString *payloadMsg = nil;
    if (payloadData)
    {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    NSLog(@"payloadMsg=%@", payloadMsg);
    
    
    
    //业务处理 ...
    NSDictionary *dict = [payloadMsg JSONValue];
    NSString *type = dict[@"method"];
    NSDictionary *customContent = [dict[@"customContent"] JSONValue];
    NSString *msg = dict[@"description"];
    
    if([type isEqualToString:@"id.verify.push"])//身份验证通知
    {
        NSNumber *state = customContent[@"state"];
        NSString *phone = customContent[@"phone"];
        
        if([DBManager getInstance].isLogin && [phone isEqualToString:[DBManager getInstance].loginModel.phone])
        {
            LoginModel *loginModel = [DBManager getInstance].loginModel;
            loginModel.state = state;
            [DBManager getInstance].loginModel = loginModel;
            
            STAlertView *alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:msg cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
            [alertView show];
        }
    }
    
    
    
    
    
    
    
    [GeTuiSdk resetBadge];
    [GeTuiSdk clearAllNotificationForNotificationBar];
}






@end
