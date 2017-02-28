//
//  InvoiceRecordRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "InvoiceRecordRequestModel.h"
#import "InvoiceRecordRespModel.h"

@interface InvoiceRecordRequest : XbedRequest

@property (nonatomic, strong)InvoiceRecordRequestModel *requestModel;
@property (nonatomic, strong)InvoiceRecordRespModel *respModel;

- (id)initWithRequestModel:(InvoiceRecordRequestModel *)model;

@end
