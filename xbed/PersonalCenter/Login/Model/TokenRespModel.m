//
//  TokenRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TokenRespModel.h"

@implementation TokenRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:LoginModel.class];
}

@end
