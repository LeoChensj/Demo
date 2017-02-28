//
//  WechatPayParamRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  获取微信支付参数

#import "XbedRequest.h"
#import "WechatPayParamRequestModel.h"
#import "WechatPayParamRespModel.h"

@interface WechatPayParamRequest : XbedRequest

@property (nonatomic, strong)WechatPayParamRequestModel *requestModel;
@property (nonatomic, strong)WechatPayParamRespModel *respModel;

- (id)initWithRequestModel:(WechatPayParamRequestModel *)model;

@end
