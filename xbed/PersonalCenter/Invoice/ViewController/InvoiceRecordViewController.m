//
//  InvoiceRecordViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceRecordViewController.h"
#import "InvoiceRecordDetailViewController.h"

@implementation InvoiceRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"开票记录";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _listView = [[InvoiceRecordListView alloc] init];
    [self.view addSubview:_listView];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
}

- (void)bindViewModel
{
    RAC(_listView, dataArray) = RACObserve(self.viewModel, invoiceRecordData);
}

- (void)handleEvent
{
    WS(ws);
    
    [[self.viewModel.commandGetInvoiceRecord execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [ws.view makeToast:x];
        }
        else
        {
            if(ws.viewModel.invoiceRecordData.count>=ws.viewModel.totalElements.integerValue)
            {
                ws.listView.footer.hidden = YES;
            }
            else
            {
                ws.listView.footer.hidden = NO;
            }
        }
        
    }];
    
    
    [_listView addInvoiceRecordListViewSelectItemBlock:^(InvoiceRecordListView *view, InvoiceRecordModel *model, NSIndexPath *indexPath) {
        
        NSLog(@"详情记录");
        
        InvoiceRecordDetailViewModel *viewModel = [[InvoiceRecordDetailViewModel alloc] init];
        viewModel.invoiceRecordDetail = model;
        PushVCWithVM(InvoiceRecordDetailViewController, viewModel);
        
    } invoiceRecordListViewLoadmoreBlock:^(InvoiceRecordListView *view) {
        
        [[ws.viewModel.commandGetMoreInvoiceRecord execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)
            {
                [ws.view makeToast:x];
            }
            else
            {
                if(ws.viewModel.invoiceRecordData.count>=ws.viewModel.totalElements.integerValue)
                {
                    view.footer.hidden = YES;
                }
            }
            
        }];
        
    }];
    
}






- (InvoiceRecordViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[InvoiceRecordViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
