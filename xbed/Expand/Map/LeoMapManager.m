//
//  LeoMapManager.m
//  xbed
//
//  Created by Leo.Chen on 16/10/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LeoMapManager.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation LeoMapManager

+ (BOOL)registerApp
{
    [AMapServices sharedServices].apiKey = AMap_Key;//高德地图
    
    return YES;
}

@end
