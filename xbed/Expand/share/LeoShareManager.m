//
//  LeoShareManager.m
//  xbed
//
//  Created by Leo.Chen on 16/10/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LeoShareManager.h"

@implementation LeoShareManager

+ (BOOL)registerApp
{
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMeng_AppKey];
    
    //[[UMSocialManager defaultManager] openLog:YES];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:Wechat_Appid appSecret:@"43a6743ffcca8afd9782cc84addd64e3" redirectURL:@"http://www.xbed.com.cn"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:Wechat_Appid appSecret:@"43a6743ffcca8afd9782cc84addd64e3" redirectURL:@"http://www.xbed.com.cn"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105008309" appSecret:@"7gqQjLgboctZoWES" redirectURL:@"http://www.xbed.com.cn"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"424705233" appSecret:@"84e1868ebee8a6d415952ed558494af3" redirectURL:@"http://www.xbed.com.cn"];
    
    
    return YES;
}

+ (BOOL)handleOpenURL:(NSURL *)url
{
    return [[UMSocialManager defaultManager] handleOpenURL:url];
}


- (void)shareToPlatform:(UMSocialPlatformType)platformType
{
    if(_messageObject)
    {
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:_messageObject currentViewController:_viewController completion:^(id result, NSError *error) {
            
            NSString *respMsg = nil;
            
            if(!error)
            {
                respMsg = @"分享成功";
            }
            else
            {
                respMsg = @"分享失败";
            }
            
            [[UIApplication sharedApplication].keyWindow makeToast:respMsg];
            
        }];
        
        
    }
    else
    {
        NSLog(@"MessageObject is nil.");
    }
}

+ (BOOL)isWechatAppInstalled
{
    return [WXApi isWXAppInstalled];
}
+ (BOOL)isQQAppInstalled
{
    return [QQApiInterface isQQInstalled];
}
+ (BOOL)isSinaAppInstalled
{
    return [WeiboSDK isWeiboAppInstalled];
}

@end
