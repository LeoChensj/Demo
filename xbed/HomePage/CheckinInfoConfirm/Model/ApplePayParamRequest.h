//
//  ApplePayParamRequest.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "ApplePayParamRequestModel.h"
#import "ApplePayParamRespModel.h"

@interface ApplePayParamRequest : XbedRequest

@property (nonatomic, strong)ApplePayParamRequestModel *requestModel;
@property (nonatomic, strong)ApplePayParamRespModel *respModel;

- (id)initWithRequestModel:(ApplePayParamRequestModel *)model;

@end
