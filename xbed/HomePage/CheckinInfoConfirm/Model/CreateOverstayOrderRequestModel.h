//
//  CreateOverstayOrderRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  生成续住单

#import "XbedRequestModel.h"

@interface CreateOverstayOrderRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSString *endDate;
@property (nonatomic, strong)NSNumber *discount;
@property (nonatomic, strong)NSNumber *activityId;
@property (nonatomic, strong)NSString *cardCode;
@property (nonatomic, strong)NSNumber *xdollar;

@end
