//
//  ScreenRoomRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenRoomRespModel.h"

@implementation ScreenRoomListModel

+ (NSValueTransformer *)coverPicJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSString *(NSString *value, BOOL *success, NSError *__autoreleasing *error) {

        if(value && value.length)
            return [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", value, (NSInteger)MAIN_SCREEN_WIDTH*2];
        else
            return nil;
        
    }];
}

@end

@implementation ScreenRoomPositionModel

+ (NSValueTransformer *)areaJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:ScreenRoomTagModel.class];
}

+ (NSValueTransformer *)buildingJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:ScreenRoomTagModel.class];
}

+ (NSValueTransformer *)businessCircleJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:ScreenRoomTagModel.class];
}

@end

@implementation ScreenRoomTagModel

@end

@implementation ScreenRoomDataModel

+ (NSValueTransformer *)bedCountTagJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:ScreenRoomTagModel.class];
}

+ (NSValueTransformer *)houseTypeTagJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:ScreenRoomTagModel.class];
}

+ (NSValueTransformer *)positionJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ScreenRoomPositionModel.class];
}

+ (NSValueTransformer *)roomFeatureTagJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:ScreenRoomTagModel.class];
}

+ (NSValueTransformer *)roomListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:ScreenRoomListModel.class];
}

+ (NSValueTransformer *)currTimeJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001+8*3600];
        NSDate *today = [CalendarHandle dateHandle2:date];
        
        return today;
        
    }];
}

@end

@implementation ScreenRoomRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ScreenRoomDataModel.class];
}

@end
