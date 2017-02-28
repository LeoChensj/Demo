//
//  LoginRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/8/31.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (id)initWithRequestModel:(LoginRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/user/login", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[LoginRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
