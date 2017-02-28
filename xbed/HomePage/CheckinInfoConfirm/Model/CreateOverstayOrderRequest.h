//
//  CreateOverstayOrderRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  生成续住单

#import "XbedRequest.h"
#import "CreateOverstayOrderRequestModel.h"
#import "CreateOverstayOrderRespModel.h"

@interface CreateOverstayOrderRequest : XbedRequest

@property (nonatomic, strong)CreateOverstayOrderRequestModel *requestModel;
@property (nonatomic, strong)CreateOverstayOrderRespModel *respModel;

- (id)initWithRequestModel:(CreateOverstayOrderRequestModel *)model;

@end
