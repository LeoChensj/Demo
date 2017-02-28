//
//  CleanTimeRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  查询可清洁时间

#import "XbedRequestModel.h"

@interface CleanTimeRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *checkinId;

@end
