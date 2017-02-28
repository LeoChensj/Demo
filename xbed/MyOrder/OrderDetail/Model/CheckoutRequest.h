//
//  CheckoutRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  办理退房

#import "XbedRequest.h"
#import "CheckoutRequestModel.h"
#import "CheckoutRespModel.h"

@interface CheckoutRequest : XbedRequest

@property (nonatomic, strong)CheckoutRequestModel *requestModel;
@property (nonatomic, strong)CheckoutRespModel *respModel;

- (id)initWithRequestModel:(CheckoutRequestModel *)model;

@end
