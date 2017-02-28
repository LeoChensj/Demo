//
//  WordOrderListRequest.m
//  xbed
//
//  Created by Leo.Chen on 2017/2/20.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "WordOrderListRequest.h"

@implementation WordOrderListRequest

- (id)initWithRequestModel:(WordOrderListRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/auth/command/orderList", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[WordOrderListRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
