//
//  RoomAddressViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"

@interface RoomAddressViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSArray <NSString *>*parkInfo;//停车信息
@property (nonatomic, strong)NSString *imageNavigation;//小区导航图

@property (nonatomic, assign)CLLocationCoordinate2D userCoordinate;
@property (nonatomic, strong)NSMutableArray <NSDictionary *>*availableMaps;


@property (nonatomic, strong, readonly)RACCommand *commandNavigate;

@end
