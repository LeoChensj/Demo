//
//  InvoiceListViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/9/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceListViewController.h"
#import "InvoiceReceiverViewController.h"

@implementation InvoiceListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_listView reloadData];
    
    BOOL flag = NO;
    if(self.viewModel.selectInvoice)
    {
        for (NSInteger i=0;i<self.viewModel.invoiceData.count;i++)
        {
            if([self.viewModel.selectInvoice.addressId isEqual:self.viewModel.invoiceData[i].addressId])
            {
                flag = YES;
                self.viewModel.invoiceData[i].flag = [NSNumber numberWithBool:YES];
                self.viewModel.selectInvoice = self.viewModel.invoiceData[i];
                break;
            }
        }
        
        if(flag==NO)
        {
            self.viewModel.selectInvoice = nil;
        }
    }
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"发票信息";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _btnAddInvoice = [[InvoiceListAddView alloc] init];
    [self.view addSubview:_btnAddInvoice];
    [_btnAddInvoice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    _listView  = [[InvoiceListView alloc] init];
    [self.view addSubview:_listView];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_btnAddInvoice.mas_bottom).offset(0);
        
    }];
}

- (void)bindViewModel
{
    RAC(_listView, dataArray) = RACObserve(self.viewModel, invoiceData);
}

- (void)handleEvent
{
    WS(ws);
    
    [[_btnAddInvoice rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        InvoiceModel *model = [[InvoiceModel alloc] init];
        model.phone = [DBManager getInstance].loginModel.phone;
        
        InvoiceReceiverViewModel *viewModel = [[InvoiceReceiverViewModel alloc] init];
        viewModel.type = 1;
        viewModel.invoiceData = ws.viewModel.invoiceData;
        viewModel.invoiceModel = model;
        PushVCWithVM(InvoiceReceiverViewController, viewModel);
        
    }];
    
    
    [_listView addInvoiceListViewSelectIconBlock:^(InvoiceListView *view, InvoiceModel *model, NSIndexPath *indexPath) {
        
        ws.viewModel.selectInvoice = model;
        [ws back];
        
    } invoiceListViewSelectIntoBlock:^(InvoiceListView *view, InvoiceModel *model, NSIndexPath *indexPath) {
        
        InvoiceReceiverViewModel *viewModel = [[InvoiceReceiverViewModel alloc] init];
        viewModel.type = 2;
        viewModel.invoiceData = ws.viewModel.invoiceData;
        viewModel.invoiceModel = [model copy];
        PushVCWithVM(InvoiceReceiverViewController, viewModel);
        
    }];
}




- (InvoiceListViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[InvoiceListViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
