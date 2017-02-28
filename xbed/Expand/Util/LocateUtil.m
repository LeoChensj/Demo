//
//  LocateUtil.m
//  xbed
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LocateUtil.h"

@implementation LocateUtil

static LocateUtil *instance = nil;

+ (LocateUtil *)getInstance
{
    static LocateUtil *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[LocateUtil alloc] init];
        
    });
    
    return instance;
}

- (void)startLocate
{
    if (![CLLocationManager locationServicesEnabled])
    {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    if(More_iOS8 && [CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
    {
        [self requestWhenInUseAuthorization];
    }
    
    self.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.distanceFilter = 10;
    self.delegate = self;
    [self startUpdatingLocation];
}

- (void)stopLocate
{
    [self stopUpdatingLocation];
}

#pragma  mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"定位成功");
    CLLocation *currentLocation = [locations lastObject];
    
    //经纬度
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    self.latitude =  [NSNumber numberWithDouble:coor.latitude];
    self.longitude = [NSNumber numberWithDouble:coor.longitude];
    
    
    //定位城市
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if(placemarks && placemarks.count>0)
        {
            CLPlacemark *placemark = placemarks[0];
            
            self.locality = placemark.locality;
        }
    }];
    
    [self stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"定位错误－%@", error);

    [self stopUpdatingLocation];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请去\"设置\"打开\"定位服务\"来允许\"Xbed\"确定您的位置" delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles:nil, nil];
    [alert show];
}

- (NSString *)getdistance:(NSString *)locate
{
    CLLocationDistance meters = 0;
    
    //房间经纬度
    CLLocation *locationRoom;
    if(locate && [locate rangeOfString:@","].length)
    {
        NSArray <NSString *>*locateArr = [locate componentsSeparatedByString:@","];
        CLLocationDegrees roomLongitude = locateArr[0].doubleValue;
        CLLocationDegrees roomLatitude = locateArr[1].doubleValue;
        locationRoom = [[CLLocation alloc] initWithLatitude:roomLatitude longitude:roomLongitude];
        
        if(_latitude && _longitude && locationRoom)
        {
            CLLocation *locationMe = [[CLLocation alloc] initWithLatitude:_latitude.doubleValue longitude:_longitude.doubleValue];
            meters = [locationMe distanceFromLocation:locationRoom];
        }
        else
        {
            NSLog(@"没定位呢！");
            return @"";
        }
    }
    
    return [self handleDistance:meters];
}

- (NSString *)getdistanceFromLongitude:(NSNumber *)longitude latitude:(NSNumber *)latitude
{
    CLLocationDistance meters = 0;
    
    //房间经纬度
    CLLocation *locationRoom;
    if(longitude && latitude)
    {
        CLLocationDegrees roomLongitude = longitude.doubleValue;
        CLLocationDegrees roomLatitude = latitude.doubleValue;
        locationRoom = [[CLLocation alloc] initWithLatitude:roomLatitude longitude:roomLongitude];
        
        if(_latitude && _longitude && locationRoom)
        {
            CLLocation *locationMe = [[CLLocation alloc] initWithLatitude:_latitude.doubleValue longitude:_longitude.doubleValue];
            meters = [locationMe distanceFromLocation:locationRoom];
        }
        else
        {
            NSLog(@"没定位呢！");
            return @"";
        }
    }
    
    return [self handleDistance:meters];
}

- (NSString *)handleDistance:(CLLocationDistance)locationDistance
{
    NSString *distance;
    
    NSInteger meters = (NSInteger)locationDistance;
    if(meters<1000)
    {
        distance = [NSString stringWithFormat:@"%ldm", meters];
    }
    else
    {
        CGFloat kiloMeters = meters/1000;
        distance = [NSString stringWithFormat:@"%.1fkm", kiloMeters];
    }
    
    return distance;
}

@end
