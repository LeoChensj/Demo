//
//  HomeMainRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomeMainRespModel.h"

@implementation HomeMainModel

@end

@implementation HomeMainDataModel

+ (NSValueTransformer *)advert1ArrayJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:HomeMainModel.class];
}

+ (NSValueTransformer *)advert2ArrayJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:HomeMainModel.class];
}

+ (NSValueTransformer *)advert3ArrayJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:HomeMainModel.class];
}

+ (NSValueTransformer *)advert4ArrayJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:HomeMainModel.class];
}

+ (NSValueTransformer *)currTimeJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001+8*3600];
        return [CalendarHandle dateHandle:date];
        
    }];
}

@end

@implementation HomeMainRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:HomeMainDataModel.class];
}

@end
