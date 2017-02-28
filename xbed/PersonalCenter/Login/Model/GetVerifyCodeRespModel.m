//
//  GetVerifyCodeRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "GetVerifyCodeRespModel.h"

@implementation GetVerifyCodeDataModel

@end

@implementation GetVerifyCodeRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:GetVerifyCodeDataModel.class];
}

@end
