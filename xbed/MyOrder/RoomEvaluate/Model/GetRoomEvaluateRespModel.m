//
//  GetRoomEvaluateRespModel.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "GetRoomEvaluateRespModel.h"

@implementation GetRoomEvaluateTermListModel

@end

@implementation GetRoomEvaluateStarTermModel

+ (NSValueTransformer *)termListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:GetRoomEvaluateTermListModel.class];
}

@end

@implementation GetRoomEvaluateWaitEvaluateModel

+ (NSValueTransformer *)cleanStarTermJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:GetRoomEvaluateStarTermModel.class];
}

+ (NSValueTransformer *)roomStarTermJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:GetRoomEvaluateStarTermModel.class];
}

@end

@implementation GetRoomEvaluateOverdueModel

+ (NSValueTransformer *)nearRoomListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:RoomDetailNearRoomsModel.class];
}

@end

@implementation GetRoomEvaluateEvaluatedModel

+ (NSValueTransformer *)nearRoomListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:RoomDetailNearRoomsModel.class];
}


@end

@implementation GetRoomEvaluateDataModel

+ (NSValueTransformer *)evaluatedJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:GetRoomEvaluateEvaluatedModel.class];
}

+ (NSValueTransformer *)overdueJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:GetRoomEvaluateOverdueModel.class];
}

+ (NSValueTransformer *)waitEvaluateJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:GetRoomEvaluateWaitEvaluateModel.class];
}

@end

@implementation GetRoomEvaluateRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:GetRoomEvaluateDataModel.class];
}

@end
