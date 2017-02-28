//
//  RoomDetailRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/9/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailRequest.h"

@implementation RoomDetailRequest

- (id)initWithRequestModel:(RoomDetailRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/room/getRoomDetail", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[RoomDetailRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
