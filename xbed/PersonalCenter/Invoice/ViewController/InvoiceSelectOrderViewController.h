//
//  InvoiceSelectOrderViewController.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  发票 订单选择列表

#import "XbedViewController.h"
#import "InvoiceSelectOrderViewModel.h"
#import "InvoiceOrderSelectView.h"
#import "BlueButton.h"
#import "DefaultView.h"

@interface InvoiceSelectOrderViewController : XbedViewController

@property (nonatomic, strong)InvoiceSelectOrderViewModel *viewModel;

@property (nonatomic, strong, readonly)InvoiceOrderSelectView *orderListView;
@property (nonatomic, strong, readonly)BlueButton *btnNext;
@property (nonatomic, strong)DefaultView *defaultView;

@end
