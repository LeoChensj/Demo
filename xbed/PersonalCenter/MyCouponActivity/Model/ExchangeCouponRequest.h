//
//  ExchangeCouponRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/11/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  兑换卡券

#import "XbedRequest.h"
#import "ExchangeCouponRequestModel.h"
#import "ExchangeCouponRespModel.h"

@interface ExchangeCouponRequest : XbedRequest

@property (nonatomic, strong)ExchangeCouponRequestModel *requestModel;
@property (nonatomic, strong)ExchangeCouponRespModel *respModel;

- (id)initWithRequestModel:(ExchangeCouponRequestModel *)model;

@end
