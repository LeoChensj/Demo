//
//  InvoiceOrderRequest.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceOrderRequest.h"

@implementation InvoiceOrderRequest

- (id)initWithRequestModel:(InvoiceOrderRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/auth/order/canInvoiceOrderList", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[InvoiceOrderRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
