//
//  CalculatePriceRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  计算价格

#import "XbedRequest.h"
#import "CalculatePriceRequestModel.h"
#import "CalculatePriceRespModel.h"

@interface CalculatePriceRequest : XbedRequest

@property (nonatomic, strong)CalculatePriceRequestModel *requestModel;
@property (nonatomic, strong)CalculatePriceRespModel *respModel;

- (id)initWithRequestModel:(CalculatePriceRequestModel *)model;

@end
