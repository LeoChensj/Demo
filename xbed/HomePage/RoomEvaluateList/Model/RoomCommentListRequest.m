//
//  RoomCommentListRequest.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomCommentListRequest.h"

@implementation RoomCommentListRequest

- (id)initWithRequestModel:(RoomCommentListRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (LeoRequestMethod)requestMethod
{
    return LeoRequestMethodGet;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/room/comment", URL_HOST];
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return [_requestModel headerParam];
}

- (id)requestParam
{
    return [_requestModel requestParam];
}

- (id)responseModel
{
    if(self.responseJSONObject)
    {
        _respModel = [MTLJSONAdapter modelOfClass:[RoomCommentListRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
