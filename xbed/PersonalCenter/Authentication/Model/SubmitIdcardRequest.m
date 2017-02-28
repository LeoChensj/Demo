//
//  SubmitIdcardRequest.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SubmitIdcardRequest.h"

@implementation SubmitIdcardRequest

- (id)initWithRequestModel:(SubmitIdcardRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/auth/userInfo/submitCheck", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[SubmitIdcardRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
