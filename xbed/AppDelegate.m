//
//  AppDelegate.m
//  xbed
//
//  Created by Leo.Chen on 16/7/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "AppDelegate.h"
#import "LeoMapManager.h"
#import "LeoPayManager.h"
#import "LeoShareManager.h"
#import "LeoAnalyticsManager.h"
#import "LeoPushManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [RootViewController getInstance];
    
    [self checkVersion];
    [self autoLogin];
    [self getAdPageData];
    
    [self config];
    
    return YES;
}


- (void)config
{
    //FPS
    #ifdef DEBUG
        [[JPFPSStatus sharedInstance] open];
    #endif
    
    
    [self configIQKeyboard];
    [self configKeyAndID];
}

- (void)configKeyAndID
{
    [LeoMapManager registerApp];
    [LeoPayManager wechatRegisterAppWithAppId:Wechat_Appid description:@"xbed"];
    [LeoShareManager registerApp];
    [LeoAnalyticsManager registerApp];
    [LeoPushManager registerApp];
    [LeoPushManager registerRemoteNotification];
    //+++...
}

- (void)configIQKeyboard
{
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

//iOS9之前
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [LeoShareManager handleOpenURL:url];
    if([url.resourceSpecifier rangeOfString:@"pay"].location!=NSNotFound)
    {
        result = NO;
    }
    
    if (!result)
    {
        // 其他如支付等SDK的回调
        if([url.scheme hasPrefix:@"wx"])//微信
        {
            return [LeoPayManager wechatHandleOpenURL:url];
        }
        else if([url.scheme hasPrefix:@"UnionPay"])//银联
        {
            return [LeoPayManager unionHandleOpenURL:url];
        }
    }
    
    return result;
}
//iOS9之后
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    BOOL result = [LeoShareManager handleOpenURL:url];
    if([url.resourceSpecifier rangeOfString:@"pay"].location!=NSNotFound)
    {
        result = NO;
    }
    
    if(!result)//支付的返回
    {
        // 其他如支付等SDK的回调
        if([url.scheme hasPrefix:@"wx"])//微信
        {
            return [LeoPayManager wechatHandleOpenURL:url];
        }
        else if([url.scheme hasPrefix:@"UnionPay"])//银联
        {
            return [LeoPayManager unionHandleOpenURL:url];
        }
    }
    
    return result;
}





//推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"DeviceToken success=%@", token);
    
    [LeoPushManager registerDeviceToken:token];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken failure");
}
//推送











- (void)checkVersion
{
    WS(ws);
    
    [[self.viewModel.commandCheckVersion execute:nil] subscribeNext:^(NSNumber *x) {
        
        if(x)//接口成功
        {
            /*
             0  不需要升级
             1  可以升级
             2  强制升级
             */
            
            if(x.integerValue==1)//可以升级
            {
                ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"检测到新版本，是否前往AppStore下载最新版？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" cancelButtonBlock:nil otherButtonBlock:^{
                    
                    NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@", Apple_AppId];
                    OpenUrl(url);
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        exit(0);
                    });
                    
                }];
                [ws.alertView show];
            }
            else if(x.integerValue==2)//强制升级
            {
                ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"检测到新版本，请前往AppStore下载最新版！" cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:^{
                    
                    NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@", Apple_AppId];
                    OpenUrl(url);
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        exit(0);
                    });
                    
                } otherButtonBlock:nil];
                [ws.alertView show];
            }
        }
        
    }];
}

- (void)autoLogin
{
    [self.viewModel.commandLogin execute:nil];
}

- (void)getAdPageData
{
    [self.viewModel.commandGetAdPageData execute:nil];
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}








- (AppDelegateViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[AppDelegateViewModel alloc] init];
    }
    
    return _viewModel;
}


@end
