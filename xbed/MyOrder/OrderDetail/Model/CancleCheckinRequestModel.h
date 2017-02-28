//
//  CancleCheckinRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  取消入住单

#import "XbedRequestModel.h"

@interface CancleCheckinRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSString *orderNo;

@end
