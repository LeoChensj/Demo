//
//  UnionPayParamRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "UnionPayParamRespModel.h"

@implementation UnionPayParamDataModel

@end

@implementation UnionPayParamRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:UnionPayParamDataModel.class];
}

@end
