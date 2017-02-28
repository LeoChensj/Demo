//
//  RoomStatusRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomStatusRespModel.h"

@implementation RoomStatusRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:RoomDetailRoomStatusModel.class];
}

@end
