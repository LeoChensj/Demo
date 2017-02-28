//
//  InvoiceRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "InvoiceRequestModel.h"
#import "InvoiceRespModel.h"

@interface InvoiceRequest : XbedRequest

@property (nonatomic, strong)InvoiceRequestModel *requestModel;
@property (nonatomic, strong)InvoiceRespModel *respModel;

- (id)initWithRequestModel:(InvoiceRequestModel *)model;

@end
