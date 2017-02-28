//
//  GetImgVerifyCodeRequest.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "GetImgVerifyCodeRequest.h"

@implementation GetImgVerifyCodeRequest

- (id)initWithRequestModel:(GetImgVerifyCodeRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/order/imageVerifyCode", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[GetImgVerifyCodeRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
