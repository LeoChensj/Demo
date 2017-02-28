//
//  NetworkOpenDoorRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/10/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  网络开门

#import "NetworkOpenDoorRequest.h"

@implementation NetworkOpenDoorRequest

- (id)initWithRequestModel:(NetworkOpenDoorRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (LeoRequestMethod)requestMethod
{
    return LeoRequestMethodPost;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/auth/lock/openDoor", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[NetworkOpenDoorRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
