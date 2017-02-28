//
//  AddInvoiceRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "AddInvoiceRequest.h"

@implementation AddInvoiceRequest

- (id)initWithRequestModel:(AddInvoiceRequestModel *)model
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
    return [NSString stringWithFormat:@"%@/api/auth/invoice/addReceiver", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[AddInvoiceRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
