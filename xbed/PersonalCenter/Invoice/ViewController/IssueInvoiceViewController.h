//
//  IssueInvoiceViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  开具发票

#import "XbedViewController.h"
#import "IssueInvoiceViewModel.h"
#import "TouchEventScrollView.h"
#import "IssueInvoiceEnableMoneyView.h"
#import "IssueInvoiceMoneyInputView.h"
#import "IssueInvoiceInfoView.h"
#import "BlueEnableButton.h"
#import "IssueInvoiceRemindView.h"

@interface IssueInvoiceViewController : XbedViewController

@property (nonatomic, strong, readonly)TouchEventScrollView *scrollView;
@property (nonatomic, strong, readonly)IssueInvoiceMoneyInputView *moneyInputView;
@property (nonatomic, strong, readonly)IssueInvoiceInfoView *invoiceInfoView;
@property (nonatomic, strong, readonly)BlueEnableButton *btnSubmit;
@property (nonatomic, strong, readonly)IssueInvoiceRemindView *remindView;
@property (nonatomic, strong)STAlertView *alertView;

@property (nonatomic, strong)IssueInvoiceViewModel *viewModel;

@end
