//
//  RoomEvaluateRespModel.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluateRespModel.h"

@implementation RoomEvaluateDataModel

+ (NSValueTransformer *)evaluatedJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:GetRoomEvaluateEvaluatedModel.class];
}

@end

@implementation RoomEvaluateRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:RoomEvaluateDataModel.class];
}

@end
