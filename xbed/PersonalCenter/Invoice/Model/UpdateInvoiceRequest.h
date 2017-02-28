//
//  UpdateInvoiceRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  修改发票

#import "XbedRequest.h"
#import "UpdateInvoiceRequestModel.h"
#import "UpdateInvoiceRespModel.h"

@interface UpdateInvoiceRequest : XbedRequest

@property (nonatomic, strong)UpdateInvoiceRequestModel *requestModel;
@property (nonatomic, strong)UpdateInvoiceRespModel *respModel;

- (id)initWithRequestModel:(UpdateInvoiceRequestModel *)model;

@end
