//
//  InvoiceRecordDetailViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "InvoiceRecordDetailViewModel.h"
#import "InvoiceRecordDetailView.h"

@interface InvoiceRecordDetailViewController : XbedViewController

@property (nonatomic, strong)InvoiceRecordDetailViewModel *viewModel;

@property (nonatomic, strong, readonly)InvoiceRecordDetailView *recordView;

@end
