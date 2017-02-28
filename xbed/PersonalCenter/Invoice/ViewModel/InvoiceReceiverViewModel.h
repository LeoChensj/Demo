//
//  InvoiceReceiverViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "InvoiceRespModel.h"

@interface InvoiceReceiverViewModel : XbedViewModel

@property (nonatomic, assign)NSInteger type;//1：添加发票  2：编辑发票
@property (nonatomic, strong)NSMutableArray <InvoiceModel *>*invoiceData;
@property (nonatomic, strong)InvoiceModel *invoiceModel;

@property (nonatomic, strong, readonly)RACSignal *signalArea;
@property (nonatomic, strong, readonly)RACSignal *signalInvoice;
@property (nonatomic, strong, readonly)RACCommand *commandAddInvoice;
@property (nonatomic, strong, readonly)RACCommand *commandDelInvoice;
@property (nonatomic, strong, readonly)RACCommand *commandUpdateInvoice;

@end
