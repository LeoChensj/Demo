//
//  SearchRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SearchRespModel.h"

@implementation SearchModel

@end

@implementation SearchDataModel

+ (NSValueTransformer *)datalistJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:SearchModel.class];
}

@end

@implementation SearchRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:SearchDataModel.class];
}

@end
