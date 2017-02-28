//
//  InvoiceOrderRequest.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "InvoiceOrderRequestModel.h"
#import "InvoiceOrderRespModel.h"

@interface InvoiceOrderRequest : XbedRequest

@property (nonatomic, strong)InvoiceOrderRequestModel *requestModel;
@property (nonatomic, strong)InvoiceOrderRespModel *respModel;

- (id)initWithRequestModel:(InvoiceOrderRequestModel *)model;

@end
