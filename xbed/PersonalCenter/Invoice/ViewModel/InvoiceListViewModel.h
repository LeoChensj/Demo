//
//  InvoiceListViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "InvoiceRespModel.h"

@interface InvoiceListViewModel : XbedViewModel

@property (nonatomic, strong)NSMutableArray <InvoiceModel *>*invoiceData;
@property (nonatomic, strong)InvoiceModel *selectInvoice;

@end
