//
//  MapUtil.h
//  xbed
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface MapUtil : NSObject

//火星坐标转换为百度坐标
+ (CLLocationCoordinate2D) mars2Bd:(CLLocationCoordinate2D)marsCoord;

+ (CLLocationCoordinate2D) bd2Mars:(CLLocationCoordinate2D)bdCoord;

/**
 * 地球坐标转换为火星坐标
 * World Geodetic System ==> Mars Geodetic System
 */
+ (CLLocationCoordinate2D) world2Mars:(CLLocationCoordinate2D)world;
@end
