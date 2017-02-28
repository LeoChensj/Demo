//
//  CheckinCleanRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  判断是否可申请在住清洁

#import "XbedRequestModel.h"

@interface CheckinCleanRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSString *orderNo;

@end
