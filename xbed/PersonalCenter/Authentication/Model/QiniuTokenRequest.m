//
//  QiniuTokenRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "QiniuTokenRequest.h"

@implementation QiniuTokenRequest

- (id)initWithRequestModel:(QiniuTokenRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/material/getQiNiuToken", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[QiniuTokenRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
