//
//  LocateUtil.h
//  xbed
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocateUtil : CLLocationManager <CLLocationManagerDelegate>

@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSString *locality;//定位城市

+ (LocateUtil *)getInstance;
- (void)startLocate;
- (void)stopLocate;
- (NSString *)getdistance:(NSString *)locate;
- (NSString *)getdistanceFromLongitude:(NSNumber *)longitude latitude:(NSNumber *)latitude;

@end
