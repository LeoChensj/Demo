//
//  IssueInvoiceViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "InvoiceOrderRespModel.h"
#import "InvoiceRespModel.h"

@interface IssueInvoiceViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *money;//开票金额
@property (nonatomic, strong)NSArray <OrderListContnetModel *>*selectOrder;//选择开票的订单

@property (nonatomic, strong)NSMutableArray <InvoiceModel *>*invoiceData;
@property (nonatomic, strong)InvoiceModel *selectInvoice;

@property (nonatomic, strong, readonly)RACSignal *signalSubmit;
@property (nonatomic, strong, readonly)RACCommand *commandGetData;
@property (nonatomic, strong, readonly)RACCommand *commandSubmit;

@end
