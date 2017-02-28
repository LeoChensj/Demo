//
//  ApplePayParamRespModel.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ApplePayParamRespModel.h"

@implementation ApplePayParamDataModel

@end

@implementation ApplePayParamRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ApplePayParamDataModel.class];
}

@end
