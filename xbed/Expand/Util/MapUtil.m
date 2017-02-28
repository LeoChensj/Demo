//
//  MapUtil.m
//  xbed
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MapUtil.h"

@implementation MapUtil

const double a = 6378245.0;
const double ee = 0.00669342162296594323;
const double x_pi = M_PI * 3000.0 / 180.0;

//火星坐标转换为百度坐标
+ (CLLocationCoordinate2D) mars2Bd:(CLLocationCoordinate2D)marsCoord
{
    double x = marsCoord.longitude, y = marsCoord.latitude;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * 3);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    CLLocationCoordinate2D bd;
    bd.longitude = z * cos(theta) + 0.0065;
    bd.latitude = z * sin(theta) + 0.006;
    return bd;
}

+ (CLLocationCoordinate2D) bd2Mars:(CLLocationCoordinate2D)bdCoord
{
    double x = bdCoord.longitude - 0.0065, y = bdCoord.latitude - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    CLLocationCoordinate2D mars;
    mars.longitude = z * cos(theta);
    mars.latitude = z * sin(theta);
    return mars;

}

bool outOfChina(double lat, double lon)
{
    if (lon < 72.004 || lon > 137.8347)
        return true;
    if (lat < 0.8293 || lat > 55.8271)
        return true;
    return false;
}

double transformLat(double x, double y)
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

double transformLon(double x, double y)
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}


/**
 * 地球坐标转换为火星坐标
 * World Geodetic System ==> Mars Geodetic System
 */
+ (CLLocationCoordinate2D) world2Mars:(CLLocationCoordinate2D)world
{
    if (outOfChina(world.longitude, world.latitude) == false)
    {
        return world;
    }
    double dLat = transformLat(world.longitude - 105.0, world.latitude - 35.0);
    double dLon = transformLon(world.longitude - 105.0, world.latitude - 35.0);
    double radLat = world.latitude / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
    CLLocationCoordinate2D mars;
    mars.latitude = world.latitude + dLat;
    mars.longitude = world.longitude + dLon;
    return mars;
}

@end
