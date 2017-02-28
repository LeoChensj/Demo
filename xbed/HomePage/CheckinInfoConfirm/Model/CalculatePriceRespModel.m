//
//  CalculatePriceRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalculatePriceRespModel.h"

@implementation CouponCardModel

+ (NSValueTransformer *)beginTimestampJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001+8*3600];
        return [CalendarHandle dateHandle2:date];
        
    }];
}

+ (NSValueTransformer *)endTimestampJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001+8*3600];
        return [CalendarHandle dateHandle2:date];
        
    }];
}

@end

@implementation couponCardDataModel

+ (NSValueTransformer *)normalsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CouponCardModel.class];
}

+ (NSValueTransformer *)disabledsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CouponCardModel.class];
}

@end

@implementation ActivityContentsModel

@end

@implementation CalculatePriceDataModel

+ (NSValueTransformer *)contentsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:ActivityContentsModel.class];
}

+ (NSValueTransformer *)couponCardJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:couponCardDataModel.class];
}

@end

@implementation CalculatePriceRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CalculatePriceDataModel.class];
}

@end
