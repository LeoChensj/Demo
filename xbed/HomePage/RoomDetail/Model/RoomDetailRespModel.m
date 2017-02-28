//
//  RoomDetailRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailRespModel.h"

@implementation RoomDetailRoomStatusModel

+ (NSValueTransformer *)calendarDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        
        return [[NSDate dateFromString:value withFormat:@"yyyy-MM-dd"] dateByAddingHour:8];
        
    }];
}

@end

@implementation RoomDetailNearRoomsModel

+ (NSValueTransformer *)coverPicJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSString *(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        
        if(value && value.length)
            return [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", value, (NSInteger)(MAIN_SCREEN_WIDTH-96)*2];
        else
            return nil;
        
    }];
}

@end

@implementation RoomDetailCommentModel

@end

@implementation RoomDetailBaseInfoModel

+ (NSValueTransformer *)custRoomAddrPicJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSString *(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        
        if(value && value.length)
            return [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", value, (NSInteger)MAIN_SCREEN_WIDTH*2];
        else
            return nil;
        
    }];
}

@end

@implementation RoomDetailAdditionModel

@end

@implementation RoomDetailDataModel

+ (NSValueTransformer *)additionJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:RoomDetailAdditionModel.class];
}

+ (NSValueTransformer *)baseInfoJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:RoomDetailBaseInfoModel.class];
}

+ (NSValueTransformer *)commentJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:RoomDetailCommentModel.class];
}

+ (NSValueTransformer *)naviPicJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:PictureModel.class];
}

+ (NSValueTransformer *)nearRoomsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:RoomDetailNearRoomsModel.class];
}

+ (NSValueTransformer *)picturesJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:PictureModel.class];
}

+ (NSValueTransformer *)roomStatusJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:RoomDetailRoomStatusModel.class];
}

@end

@implementation RoomDetailRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:RoomDetailDataModel.class];
}

@end
