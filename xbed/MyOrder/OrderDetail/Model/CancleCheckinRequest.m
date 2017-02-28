//
//  CancleCheckinRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CancleCheckinRequest.h"

@implementation CancleCheckinRequest

- (id)initWithRequestModel:(CancleCheckinRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/auth/order/cancelCheckinOrder", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[CancleCheckinRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
