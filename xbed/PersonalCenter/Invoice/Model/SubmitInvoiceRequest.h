//
//  SubmitInvoiceRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  开发票

#import "XbedRequest.h"
#import "SubmitInvoiceRequestModel.h"
#import "SubmitInvoiceRespModel.h"

@interface SubmitInvoiceRequest : XbedRequest

@property (nonatomic, strong)SubmitInvoiceRequestModel *requestModel;
@property (nonatomic, strong)SubmitInvoiceRespModel *respModel;

- (id)initWithRequestModel:(SubmitInvoiceRequestModel *)model;

@end
