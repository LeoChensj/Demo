//
//  LeoAnalyticsManager.m
//  xbed
//
//  Created by Leo.Chen on 16/10/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LeoAnalyticsManager.h"
#import "UMMobClick/MobClick.h"

@implementation LeoAnalyticsManager

+ (BOOL)registerApp
{
    UMConfigInstance.appKey = UMeng_AppKey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
    return YES;
}

@end
