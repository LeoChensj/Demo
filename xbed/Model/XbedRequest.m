//
//  XbedRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/7/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "TokenRequest.h"
#import "LoginViewController.h"

//@class TokenRequest;

@implementation XbedRequest

- (NSTimeInterval)requestTimeoutInterval
{
    return 60;
}

- (LeoRequestMethod)requestMethod
{
    return LeoRequestMethodPost;
}

- (LeoRequestSerializerType)requestSerializerType
{
    return LeoRequestSerializerTypeHTTP;
}

- (LeoResponseSerializerType)responseSerializerType
{
    return LeoResponseSerializerTypeHTTP;
}

- (BOOL)checkResult
{
    if (self.responseJSONObject)
    {
        if([self getRetCode]==41020003)//token失效
        {
            DBManager *manager = [DBManager getInstance];
            manager.isLogin = NO;
            manager.token = nil;
            
            if([self isMemberOfClass:[TokenRequest class]]==NO)
            {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                XbedViewController *currentVC = (XbedViewController *)[RootViewController getInstance].topViewController;
                [currentVC presentViewController:loginVC animated:YES completion:nil];
            }
        }
        
        NSNumber *status = [self.responseJSONObject objectForKey:@"status"];
        if(status && ![status isEqual:[NSNull null]])
        {
            return status.boolValue;
        }
    }
    
    return NO;
}

- (NSInteger)getRetCode
{
    if (self.responseJSONObject)
    {
        return [[self.responseJSONObject objectForKey:@"retCode"] integerValue];
    }
    
    return -999;
}

- (NSString *)getErrorMsg
{
    if (self.responseJSONObject)
    {
        return [self.responseJSONObject objectForKey:@"msg"];
    }
    
    return @"您的网络不太给力，请稍后再试";
}

- (id)responseModel
{
    return nil;
}


@end
