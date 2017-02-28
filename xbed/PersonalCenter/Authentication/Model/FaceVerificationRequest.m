//
//  FaceVerificationRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/11/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "FaceVerificationRequest.h"

@implementation FaceVerificationRequest

- (id)initWithRequestModel:(FaceVerificationRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (NSTimeInterval)requestTimeoutInterval
{
    return 100;
}

- (LeoRequestMethod)requestMethod
{
    return LeoRequestMethodPost;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/auth/inVivoVerification", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[FaceVerificationRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
