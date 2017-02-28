//
//  RoomAddressMapView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface RoomAddressMapView : MAMapView <MAMapViewDelegate>

@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSNumber *latitude;//
@property (nonatomic, assign)CLLocationCoordinate2D userCoordinate;//用户定位经纬度
@property (nonatomic, strong)NSString *address;

@end
