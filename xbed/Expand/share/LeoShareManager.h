//
//  LeoShareManager.h
//  xbed
//
//  Created by Leo.Chen on 16/10/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"

@interface LeoShareManager : NSObject

@property (nonatomic, strong)UMSocialMessageObject *messageObject;
@property (nonatomic, strong)id viewController;

+ (BOOL)registerApp;
+ (BOOL)handleOpenURL:(NSURL *)url;

+ (BOOL)isWechatAppInstalled;
+ (BOOL)isQQAppInstalled;
+ (BOOL)isSinaAppInstalled;

- (void)shareToPlatform:(UMSocialPlatformType)platformType;

@end
