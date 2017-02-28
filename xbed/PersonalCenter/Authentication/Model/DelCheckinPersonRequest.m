//
//  DelCheckinPersonRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "DelCheckinPersonRequest.h"

@implementation DelCheckinPersonRequest

- (id)initWithRequestModel:(DelCheckinPersonRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (LeoRequestMethod)requestMethod
{
    return LeoRequestMethodDelete;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/auth/userInfo/delCheckinPerson", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[DelCheckinPersonRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
