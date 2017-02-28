//
//  InvoiceRecordDetailViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceRecordDetailViewController.h"

@implementation InvoiceRecordDetailViewController

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
    _recordView = [[InvoiceRecordDetailView alloc] init];
    [self.view addSubview:_recordView];
    [_recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
}

- (void)bindViewModel
{
    RAC(_recordView, invoiceRecordDetail) = RACObserve(self.viewModel, invoiceRecordDetail);
}

- (void)handleEvent
{
    
}





- (InvoiceRecordDetailViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[InvoiceRecordDetailViewModel alloc] init];
    }
    
    return _viewModel;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
