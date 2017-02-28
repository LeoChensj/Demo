//
//  ClientIdRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/11/3.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ClientIdRequest.h"

@implementation ClientIdRequest

- (id)initWithRequestModel:(ClientIdRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (LeoRequestMethod)requestMethod
{
    return LeoRequestMethodPut;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/user/clientId", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[ClientIdRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
