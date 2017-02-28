//
//  CheckinRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/10/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinRequest.h"

@implementation CheckinRequest

- (id)initWithRequestModel:(CheckinRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/auth/order/checkin", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[CheckinRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
