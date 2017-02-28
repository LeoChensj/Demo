//
//  TokenRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/9/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TokenRequest.h"

@implementation TokenRequest

- (id)initWithRequestModel:(TokenRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/auth/personal/getHomePageInfo", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[TokenRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
