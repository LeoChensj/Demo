//
//  UIDataRequest.m
//  xbed
//
//  Created by Leo.Chen on 2017/1/13.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "UIDataRequest.h"

@implementation UIDataRequest

- (id)initWithRequestModel:(UIDataRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/app/getAppUISetting", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[UIDataRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end