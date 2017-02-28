//
//  ApplePayParamRequest.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ApplePayParamRequest.h"

@implementation ApplePayParamRequest

- (id)initWithRequestModel:(ApplePayParamRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/auth/order/getApplePayParam", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[ApplePayParamRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
