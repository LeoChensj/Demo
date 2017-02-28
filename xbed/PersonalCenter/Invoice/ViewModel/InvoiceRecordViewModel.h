//
//  InvoiceRecordViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "InvoiceRecordRespModel.h"

@interface InvoiceRecordViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *page;
@property (nonatomic, strong)NSNumber *size;
@property (nonatomic, strong)NSNumber *totalElements;
@property (nonatomic, strong)NSArray <InvoiceRecordModel *>*invoiceRecordData;

@property (nonatomic, strong, readonly)RACCommand *commandGetInvoiceRecord;
@property (nonatomic, strong, readonly)RACCommand *commandGetMoreInvoiceRecord;

@end
