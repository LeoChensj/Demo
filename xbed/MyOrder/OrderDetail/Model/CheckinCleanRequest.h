//
//  CheckinCleanRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  判断是否可申请在住清洁

#import "XbedRequest.h"
#import "CheckinCleanRequestModel.h"
#import "CheckinCleanRespModel.h"

@interface CheckinCleanRequest : XbedRequest

@property (nonatomic, strong)CheckinCleanRequestModel *requestModel;
@property (nonatomic, strong)CheckinCleanRespModel *respModel;

- (id)initWithRequestModel:(CheckinCleanRequestModel *)model;

@end
