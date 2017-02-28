//
//  InvoiceSelectOrderViewModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "InvoiceOrderRespModel.h"

@interface InvoiceSelectOrderViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *page;
@property (nonatomic, strong)NSNumber *size;
@property (nonatomic, strong)NSArray <OrderListContnetModel *>*orderData;
@property (nonatomic, strong)NSNumber *totalElements;

@property (nonatomic, strong)NSArray <OrderListContnetModel *>*selectOrder;
@property (nonatomic, strong)NSNumber *invoicePrice;

@property (nonatomic, strong, readonly)RACSignal *signalNext;
@property (nonatomic, strong, readonly)RACCommand *commandGetOrderList;
@property (nonatomic, strong, readonly)RACCommand *commandGetMoreOrderList;

@end
