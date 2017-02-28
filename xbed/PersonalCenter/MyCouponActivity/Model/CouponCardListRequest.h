//
//  CouponCardListRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  获取用户卡券列表

#import "XbedRequest.h"
#import "CouponCardListRequestModel.h"
#import "CouponCardListRespModel.h"

@interface CouponCardListRequest : XbedRequest

@property (nonatomic, strong)CouponCardListRequestModel *requestModel;
@property (nonatomic, strong)CouponCardListRespModel *respModel;

- (id)initWithRequestModel:(CouponCardListRequestModel *)model;

@end
