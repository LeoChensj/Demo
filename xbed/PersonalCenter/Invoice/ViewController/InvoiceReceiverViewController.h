//
//  InvoiceReceiverViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  发票收件人

#import "XbedViewController.h"
#import "InvoiceReceiverViewModel.h"
#import "TouchEventScrollView.h"
#import "InputTableCell.h"
#import "NormalTableCell2.h"
#import "BlueEnableButton.h"

@interface InvoiceReceiverViewController : XbedViewController

@property (nonatomic, strong)InvoiceReceiverViewModel *viewModel;

@property (nonatomic, strong, readonly)TouchEventScrollView *scrollView;
@property (nonatomic, strong, readonly)InputTableCell *cellTitle;
@property (nonatomic, strong, readonly)InputTableCell *cellRealName;
@property (nonatomic, strong, readonly)InputTableCell *cellPhone;
@property (nonatomic, strong, readonly)NormalTableCell2 *cellArea;
@property (nonatomic, strong, readonly)InputTableCell *cellAddress;
@property (nonatomic, strong, readonly)BlueEnableButton *btnSave;

@end
