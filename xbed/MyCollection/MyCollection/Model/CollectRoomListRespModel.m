//
//  CollectRoomListRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CollectRoomListRespModel.h"

@implementation CollectRoomListModel

@end

@implementation CollectRoomListDataModel

+ (NSValueTransformer *)roomListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CollectRoomListModel.class];
}

@end

@implementation CollectRoomListRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CollectRoomListDataModel.class];
}

@end
