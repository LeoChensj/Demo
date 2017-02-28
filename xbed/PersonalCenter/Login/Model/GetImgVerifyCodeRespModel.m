//
//  GetImgVerifyCodeRespModel.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "GetImgVerifyCodeRespModel.h"

@implementation GetImgVerifyCodeDataModel

@end

@implementation GetImgVerifyCodeRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:GetImgVerifyCodeDataModel.class];
}

@end
