//
//  OrderListRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderListRespModel.h"

@implementation OrderListRoomInfoModel

+ (NSValueTransformer *)pictureJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSString *(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        
        if(value && value.length)
            return [NSString stringWithFormat:@"%@?imageView2/2/w/270", value];
        else
            return nil;
        
    }];
}

@end

@implementation CheckinOrderListModel

+ (NSValueTransformer *)checkinDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001+8*3600];
        return [CalendarHandle dateHandle2:date];
        
    }];
}

+ (NSValueTransformer *)checkoutDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001+8*3600];
        return [CalendarHandle dateHandle2:date];
        
    }];
}

+ (NSValueTransformer *)roomInfoJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:OrderListRoomInfoModel.class];
}

@end

@implementation OrderListContnetModel

+ (NSValueTransformer *)checkinOrderListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CheckinOrderListModel.class];
}

@end

@implementation OrderListDataModel

+ (NSValueTransformer *)contentsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:OrderListContnetModel.class];
}

@end

@implementation OrderListRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:OrderListDataModel.class];
}

@end
