//
//  CheckVersionRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckVersionRequest.h"

@implementation CheckVersionRequest

- (id)initWithRequestModel:(CheckVersionRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/app/findVersion", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[CheckVersionRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
