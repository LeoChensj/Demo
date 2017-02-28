//
//  ExchangeCouponRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/11/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ExchangeCouponRequest.h"

@implementation ExchangeCouponRequest

- (id)initWithRequestModel:(ExchangeCouponRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/auth/activity/getPreferentialCode", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[ExchangeCouponRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
