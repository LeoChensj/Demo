//
//  InvoiceListViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/9/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "InvoiceListViewModel.h"
#import "InvoiceListAddView.h"
#import "InvoiceListView.h"

@interface InvoiceListViewController : XbedViewController

@property (nonatomic, strong, readonly)InvoiceListAddView *btnAddInvoice;
@property (nonatomic, strong, readonly)InvoiceListView *listView;

@property (nonatomic, strong)InvoiceListViewModel *viewModel;

@end
