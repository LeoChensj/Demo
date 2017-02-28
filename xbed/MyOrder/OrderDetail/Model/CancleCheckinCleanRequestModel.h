//
//  CancleCheckinCleanRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  取消清洁单

#import "XbedRequestModel.h"

@interface CancleCheckinCleanRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSString *orderNo;

@end
