//
//  CheckinOrderInfoRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinOrderInfoRespModel.h"

@implementation CheckinOrderRoomInfoModel

+ (NSValueTransformer *)pictureJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSString *(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        
        if(value && value.length)
            return [NSString stringWithFormat:@"%@?imageView2/2/w/268", value];
        else
            return nil;
        
    }];
}

@end

@implementation CheckinOrderPayInfoPriceListModel

+ (NSValueTransformer *)curDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001+8*3600];
        return [CalendarHandle dateHandle2:date];
        
    }];
}

@end

@implementation CheckinOrderPayInfoModel

+ (NSValueTransformer *)curPriceListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CheckinOrderPayInfoPriceListModel.class];
}

@end

@implementation CheckinOrderCheckinerModel

@end

@implementation CheckinOrderInfoModel

+ (NSValueTransformer *)checkinDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001+8*3600];
//        return [CalendarHandle dateHandle2:date];
        return [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001];
        
    }];
}

+ (NSValueTransformer *)checkoutDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001+8*3600];
//        return [CalendarHandle dateHandle2:date];
        return [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001];
        
    }];
}

@end


@implementation CheckinOrderInfoDataModel

+ (NSValueTransformer *)checkinOrderInfoJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CheckinOrderInfoModel.class];
}

+ (NSValueTransformer *)checkinerListJSONTransformer//checkinerList
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CheckinOrderCheckinerModel.class];
}

+ (NSValueTransformer *)payInfoJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CheckinOrderPayInfoModel.class];
}

+ (NSValueTransformer *)roomInfoJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CheckinOrderRoomInfoModel.class];
}

@end



@implementation CheckinOrderInfoRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CheckinOrderInfoDataModel.class];
}

@end
