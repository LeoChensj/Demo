//
//  WechatPayParamRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface WechatPayParamDataModel : XbedModel

@property (nonatomic, strong)NSString *appid;
@property (nonatomic, strong)NSString *noncestr;
@property (nonatomic, strong)NSString *packageName;
@property (nonatomic, strong)NSString *partnerid;
@property (nonatomic, strong)NSString *prepayid;
@property (nonatomic, strong)NSString *sign;
@property (nonatomic, strong)NSString *timestamp;

@end

@interface WechatPayParamRespModel : XbedRespModel

@property (nonatomic, strong)WechatPayParamDataModel *data;

@end
