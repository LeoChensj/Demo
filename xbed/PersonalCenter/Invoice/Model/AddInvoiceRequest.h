//
//  AddInvoiceRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  添加发票

#import "XbedRequest.h"
#import "AddInvoiceRequestModel.h"
#import "AddInvoiceRespModel.h"

@interface AddInvoiceRequest : XbedRequest

@property (nonatomic, strong)AddInvoiceRequestModel *requestModel;
@property (nonatomic, strong)AddInvoiceRespModel *respModel;

- (id)initWithRequestModel:(AddInvoiceRequestModel *)model;

@end
