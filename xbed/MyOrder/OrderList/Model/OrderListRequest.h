//
//  OrderListRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  订单列表

#import "XbedRequest.h"
#import "OrderListRequestModel.h"
#import "OrderListRespModel.h"

@interface OrderListRequest : XbedRequest

@property (nonatomic, strong)OrderListRequestModel *requestModel;
@property (nonatomic, strong)OrderListRespModel *respModel;

- (id)initWithRequestModel:(OrderListRequestModel *)model;

@end
