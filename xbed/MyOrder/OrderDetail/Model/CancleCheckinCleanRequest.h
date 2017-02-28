//
//  CancleCheckinCleanRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  取消清洁单

#import "XbedRequest.h"
#import "CancleCheckinCleanRequestModel.h"
#import "CancleCheckinCleanRespModel.h"

@interface CancleCheckinCleanRequest : XbedRequest

@property (nonatomic, strong)CancleCheckinCleanRequestModel *requestModel;
@property (nonatomic, strong)CancleCheckinCleanRespModel *respModel;

- (id)initWithRequestModel:(CancleCheckinCleanRequestModel *)model;

@end
