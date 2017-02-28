//
//  SubmitInvoiceRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/10/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SubmitInvoiceRequest.h"

@implementation SubmitInvoiceRequest

- (id)initWithRequestModel:(SubmitInvoiceRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (LeoRequestMethod)requestMethod
{
    return LeoRequestMethodPost;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/auth/invoice/saveInvoice", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[SubmitInvoiceRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
