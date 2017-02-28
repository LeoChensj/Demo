//
//  WechatPayParamRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "WechatPayParamRespModel.h"

@implementation WechatPayParamDataModel

@end

@implementation WechatPayParamRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WechatPayParamDataModel.class];
}

@end
