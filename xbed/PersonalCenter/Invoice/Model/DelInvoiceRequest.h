//
//  DelInvoiceRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  删除发票

#import "XbedRequest.h"
#import "DelInvoiceRequestModel.h"
#import "DelInvoiceRespModel.h"

@interface DelInvoiceRequest : XbedRequest

@property (nonatomic, strong)DelInvoiceRequestModel *requestModel;
@property (nonatomic, strong)DelInvoiceRespModel *respModel;

- (id)initWithRequestModel:(DelInvoiceRequestModel *)model;

@end
