//
//  UnionPayParamRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  获取银联支付参数

#import "XbedRequest.h"
#import "UnionPayParamRequestModel.h"
#import "UnionPayParamRespModel.h"

@interface UnionPayParamRequest : XbedRequest

@property (nonatomic, strong)UnionPayParamRequestModel *requestModel;
@property (nonatomic, strong)UnionPayParamRespModel *respModel;

- (id)initWithRequestModel:(UnionPayParamRequestModel *)model;

@end
