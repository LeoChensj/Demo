//
//  InvoiceRecordViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  开票记录

#import "XbedViewController.h"
#import "InvoiceRecordViewModel.h"
#import "InvoiceRecordListView.h"

@interface InvoiceRecordViewController : XbedViewController

@property (nonatomic, strong)InvoiceRecordViewModel *viewModel;

@property (nonatomic, strong, readonly)InvoiceRecordListView *listView;

@end
