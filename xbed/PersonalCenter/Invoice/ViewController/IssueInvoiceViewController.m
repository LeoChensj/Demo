//
//  IssueInvoiceViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "IssueInvoiceViewController.h"
#import "InvoiceListViewController.h"
#import "InvoiceRecordViewController.h"

@implementation IssueInvoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"开具发票";
    self.headView.txtRight = @"开票记录";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
    
    [[self.headView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"开票记录");
        
        PushVC(InvoiceRecordViewController, YES);
        
    }];
}

- (void)setupView
{
    _scrollView = [[TouchEventScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
    
    _moneyInputView = [[IssueInvoiceMoneyInputView alloc] init];
    [_scrollView addSubview:_moneyInputView];
    [_moneyInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(98);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        
    }];
    
    
    _invoiceInfoView = [[IssueInvoiceInfoView alloc] init];
    [_scrollView addSubview:_invoiceInfoView];
    [_invoiceInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_moneyInputView.mas_bottom).offset(10);
        
    }];
    
    
    _btnSubmit = [[BlueEnableButton alloc] init];
    _btnSubmit.title = @"提 交";
    [_scrollView addSubview:_btnSubmit];
    [_btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_invoiceInfoView.mas_bottom).offset(40);
        
    }];
    
    
    _remindView = [[IssueInvoiceRemindView alloc] init];
    [_scrollView addSubview:_remindView];
    [_remindView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(_remindView.myHeight);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_btnSubmit.mas_bottom).offset(30);
        
    }];
    
    
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_remindView.mas_bottom).offset(10);
        
    }];
}

- (void)bindViewModel
{
    RAC(_moneyInputView, money) = RACObserve(self.viewModel, money);
    RAC(_invoiceInfoView, model) = RACObserve(self.viewModel, selectInvoice);
    RAC(_btnSubmit, enabled) = self.viewModel.signalSubmit;
}

- (void)handleEvent
{
    WS(ws);
    
    [[self.viewModel.commandGetData execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [[UIApplication sharedApplication].keyWindow makeToast:x];
            [ws back];
        }
        
    }];
    
    InvoiceListViewModel *viewModel = [[InvoiceListViewModel alloc] init];
    RAC(ws.viewModel, selectInvoice) = RACObserve(viewModel, selectInvoice);
    
    [[_invoiceInfoView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        viewModel.invoiceData = ws.viewModel.invoiceData;
        viewModel.selectInvoice = ws.viewModel.selectInvoice;
        PushVCWithVM(InvoiceListViewController, viewModel);
        
    }];
    
    
    [[_btnSubmit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws.view endEditing:YES];
        
        if(ws.viewModel.money.integerValue>=100 && ws.viewModel.money.integerValue<200*100)
        {
            ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"开票金额少于200元，需自行承担运费（快递到付）" cancelButtonTitle:@"取消" otherButtonTitle:@"继续开票" cancelButtonBlock:nil otherButtonBlock:^{
                
                [ws submit];
                
            }];
            [ws.alertView show];
        }
        else
        {
            [ws submit];
        }
        
        
    }];
}


- (void)submit
{
    WS(ws);
    [[self.viewModel.commandSubmit execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [ws.view makeToast:x];
        }
        else
        {
            //[[UIApplication sharedApplication].keyWindow makeToast:@"开票成功"];
            
            [[UIApplication sharedApplication].keyWindow makeToast:@"开票成功" duration:3 position:[CSToastManager defaultPosition] style:nil];

            
            NSMutableArray *tempVC = [NSMutableArray arrayWithArray:[RootViewController getInstance].viewControllers];
            [tempVC removeLastObject];
            [tempVC removeLastObject];
            
            [[RootViewController getInstance] setViewControllers:tempVC animated:YES];
        }
        
    }];
}




- (IssueInvoiceViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[IssueInvoiceViewModel alloc] init];
    }
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}


@end
