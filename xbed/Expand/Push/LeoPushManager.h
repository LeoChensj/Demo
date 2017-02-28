//
//  LeoPushManager.h
//  xbed
//
//  Created by Leo.Chen on 16/10/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeTuiSdk.h"

#if ENV==0 || ENV==1 || ENV==2//开发、测试、预发布
    #define GeTuiAppID          @"1AOCgWQYPm8UfGmNRmXok5"
    #define GeTuiAppSecret      @"H2TQ6WpAuWAufd8ZXaTiz2"
    #define GeTuiAppKey         @"cQzFeoGi9r5KVarTxGpd39"
#elif ENV == 3//生产(AppStore)
    #define GeTuiAppID          @"oHLcypyOio7QYXnPBKPGQ3"
    #define GeTuiAppSecret      @"wd4SU5IuwX92NMeOkJ6AV2"
    #define GeTuiAppKey         @"IPJCKKcSzz6KzFT3aTYUq1"
#endif


@interface LeoPushManager : NSObject <GeTuiSdkDelegate>

+ (LeoPushManager *)getInstance;

+ (BOOL)registerApp;
+ (void)registerRemoteNotification;
+ (void)registerDeviceToken:(NSString *)deviceToken;

@end
