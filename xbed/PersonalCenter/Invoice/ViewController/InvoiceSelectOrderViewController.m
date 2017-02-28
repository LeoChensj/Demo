//
//  InvoiceSelectOrderViewController.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceSelectOrderViewController.h"
#import "InvoiceRecordViewController.h"
#import "IssueInvoiceViewController.h"

@implementation InvoiceSelectOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"选择订单";
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
    _orderListView = [[InvoiceOrderSelectView alloc] init];
    [self.view addSubview:_orderListView];
    [_orderListView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-49);
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        
    }];
    
    _btnNext = [[BlueButton alloc] init];
    _btnNext.title = @"下一步";
    [self.view addSubview:_btnNext];
    [_btnNext mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        
    }];
}

- (void)bindViewModel
{
    RAC(_btnNext, enabled) = self.viewModel.signalNext;
    RAC(_orderListView, dataArray) = RACObserve(self.viewModel, orderData);
    RAC(self.viewModel, selectOrder) = RACObserve(_orderListView, selectOrder);
    RAC(self.viewModel, invoicePrice) = RACObserve(_orderListView, invoicePrice);
}

- (void)handleEvent
{
    WS(ws);
    
    [self visitNetworkToGetOrderList];
    
    [_orderListView addInvoiceOrderSelectViewLoadmoreBlock:^(MJRefreshAutoStateFooter *footerView) {
        
        [[ws.viewModel.commandGetMoreOrderList execute:nil] subscribeNext:^(NSString *x) {
            
            [footerView endRefreshing];
            
            if(x && x.length)
            {
                [ws.view makeToast:x];
            }
            else
            {
                if(ws.viewModel.totalElements.integerValue<=ws.viewModel.orderData.count)
                {
                    ws.orderListView.footer.hidden = YES;
                }
                else
                {
                    ws.orderListView.footer.hidden = NO;
                }
            }
            
        }];
        
    }];
    
    
    [[_btnNext rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"下一步");
        
        IssueInvoiceViewModel *viewModel = [[IssueInvoiceViewModel alloc] init];
        viewModel.money = ws.viewModel.invoicePrice;
        viewModel.selectOrder = ws.viewModel.selectOrder;
        PushVCWithVM(IssueInvoiceViewController, viewModel);
        
    }];
    
}


- (void)visitNetworkToGetOrderList
{
    WS(ws);
    
    [[self.viewModel.commandGetOrderList execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            //[ws.view makeToast:x];
            
            ws.defaultView.type = DefaultViewNoNetwork;
            ws.defaultView.hidden = NO;
            [[ws.defaultView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                [ws visitNetworkToGetOrderList];
                
            }];
        }
        else
        {
            if(ws.viewModel.orderData.count>0)
            {
                ws.defaultView.hidden = YES;
            }
            else
            {
                ws.defaultView.hidden = NO;
                ws.defaultView.type = DefaultViewNoOrder;
                [[ws.defaultView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                    
                    [CustomTabBarController getInstance].index = TabBarIndexHome;
                    [ws back];
                    
                }];
            }
            
            if(ws.viewModel.totalElements.integerValue<=ws.viewModel.orderData.count)
            {
                ws.orderListView.footer.hidden = YES;
            }
            else
            {
                ws.orderListView.footer.hidden = NO;
            }
        }
        
    }];
}




- (DefaultView *)defaultView
{
    if(_defaultView==nil)
    {
        _defaultView = [[DefaultView alloc] init];
        [self.view addSubview:_defaultView];
    }
    
    return _defaultView;
}

- (InvoiceSelectOrderViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[InvoiceSelectOrderViewModel alloc] init];
    }
    
    return _viewModel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
