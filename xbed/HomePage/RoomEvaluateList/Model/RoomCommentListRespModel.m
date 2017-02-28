//
//  RoomCommentListRespModel.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomCommentListRespModel.h"

@implementation RoomCommentListModel

+ (NSValueTransformer *)createDateJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001];
        return date;
        
    }];
}


@end

@implementation RoomCommentListDataModel

+ (NSValueTransformer *)commentListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:RoomCommentListModel.class];
}

@end

@implementation RoomCommentListRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:RoomCommentListDataModel.class];
}

@end
