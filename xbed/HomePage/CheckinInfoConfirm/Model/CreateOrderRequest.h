//
//  CreateOrderRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  生成订单

#import "XbedRequest.h"
#import "CreateOrderRequestModel.h"
#import "CreateOrderRespModel.h"

@interface CreateOrderRequest : XbedRequest

@property (nonatomic, strong)CreateOrderRequestModel *requestModel;
@property (nonatomic, strong)CreateOrderRespModel *respModel;

- (id)initWithRequestModel:(CreateOrderRequestModel *)model;

@end
