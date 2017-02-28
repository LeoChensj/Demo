//
//  CalculatePriceRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/9/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalculatePriceRequest.h"

@implementation CalculatePriceRequest

- (id)initWithRequestModel:(CalculatePriceRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/auth/order/calculatePrice", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[CalculatePriceRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
