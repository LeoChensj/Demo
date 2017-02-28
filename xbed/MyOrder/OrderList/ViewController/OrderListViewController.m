//
//  OrderListViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderDetailViewController.h"
#import "LoginViewController.h"
#import "OrderWordShowView.h"

@implementation OrderListViewController

@synthesize defaultView0 = _defaultView0;
@synthesize defaultView1 = _defaultView1;
@synthesize defaultView2 = _defaultView2;
@synthesize defaultView3 = _defaultView3;
@synthesize defaultView4 = _defaultView4;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([DBManager getInstance].isLogin)
    {
        [self visitNetworkToGetOrderList];
    }
    else
    {
        self.defaultView1.hidden = NO;
        self.defaultView1.type = DefaultViewNoLoginWithOrder;
        self.defaultView1.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
        self.defaultView1.button.tag = 100;
        [self.defaultView1.button addTarget:self action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.defaultView2.hidden = NO;
        self.defaultView2.type = DefaultViewNoLoginWithOrder;
        self.defaultView2.frame = CGRectMake(MAIN_SCREEN_WIDTH, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
        self.defaultView2.button.tag = 100;
        [self.defaultView2.button addTarget:self action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.defaultView3.hidden = NO;
        self.defaultView3.type = DefaultViewNoLoginWithOrder;
        self.defaultView3.frame = CGRectMake(MAIN_SCREEN_WIDTH*2, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
        self.defaultView3.button.tag = 100;
        [self.defaultView3.button addTarget:self action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.defaultView4.hidden = NO;
        self.defaultView4.type = DefaultViewNoLoginWithOrder;
        self.defaultView4.frame = CGRectMake(MAIN_SCREEN_WIDTH*3, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
        self.defaultView4.button.tag = 100;
        [self.defaultView4.button addTarget:self action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.defaultView0.hidden = NO;
        self.defaultView0.type = DefaultViewNoLoginWithOrder;
        self.defaultView0.frame = CGRectMake(MAIN_SCREEN_WIDTH*4, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
        self.defaultView0.button.tag = 100;
        [self.defaultView0.button addTarget:self action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"订单";
    self.headView.txtRight = @"输入口令";
    [self.view addSubview:self.headView];
    
    WS(ws);
    @weakify(self);
    [[self.headView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"输入口令");
        @strongify(self);
        
        if([DBManager getInstance].isLogin)
        {
            OrderWordShowView *orderWordShowView = [[OrderWordShowView alloc] initWithType:1];
            [ws.view addSubview:orderWordShowView];
            
            ws.viewModel.isWord = YES;
            
            RAC(ws.viewModel, word) = orderWordShowView.cellWord.tfValue.rac_textSignal;
            RAC(ws.viewModel, name) = orderWordShowView.cellName.tfValue.rac_textSignal;
            RAC(ws.viewModel, phone) = orderWordShowView.cellPhone.tfValue.rac_textSignal;
            
            [orderWordShowView addOrderWordShowViewConfirmBlock:^{
                
                [[ws.viewModel.commandGetWordOrderData execute:nil] subscribeNext:^(NSString *x) {
                    
                    if(x.length)
                    {
                        [[UIApplication sharedApplication].keyWindow makeToast:x];
                    }
                    else
                    {
                        ws.stateSelectView.index = @4;
                        
                        if(ws.viewModel.orderData0.count==0)
                        {
                            ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"该口令未关联订单" cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
                            [ws.alertView show];
                        }
                    }
                    
                    ws.viewModel.isWord = NO;
                    
                }];
                
            }];
            
            [orderWordShowView addOrderWordShowViewCloseBlock:^{
                
                ws.viewModel.isWord = NO;
                
            }];
        }
        else
        {
            PresentVC(LoginViewController);
        }
        
        
    }];
}

- (void)setupView
{
    _scrollView = [[OrderListBackScrollView alloc] init];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-45);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64+45);
        
    }];
    
    
    _orderListView1 = [[OrderListView alloc] init];
    [_scrollView addSubview:_orderListView1];
    [_orderListView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-45);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        
    }];
    
    _orderListView2 = [[OrderListView alloc] init];
    [_scrollView addSubview:_orderListView2];
    [_orderListView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-45);
        make.left.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.top.mas_equalTo(0);
        
    }];
    
    _orderListView3 = [[OrderListView alloc] init];
    [_scrollView addSubview:_orderListView3];
    [_orderListView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-45);
        make.left.mas_equalTo(MAIN_SCREEN_WIDTH*2);
        make.top.mas_equalTo(0);
        
    }];
    
    _orderListView4 = [[OrderListView alloc] init];
    [_scrollView addSubview:_orderListView4];
    [_orderListView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-45);
        make.left.mas_equalTo(MAIN_SCREEN_WIDTH*3);
        make.top.mas_equalTo(0);
        
    }];
    
    _orderListView0 = [[OrderListView alloc] init];
    [_scrollView addSubview:_orderListView0];
    [_orderListView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-45);
        make.left.mas_equalTo(MAIN_SCREEN_WIDTH*4);
        make.top.mas_equalTo(0);
        
    }];
    
    
    
    _stateSelectView = [[OrderListStateSelectView alloc] init];
    [self.view addSubview:_stateSelectView];
    [_stateSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
}

- (void)bindViewModel
{
    RAC(_orderListView1, dataArray) = RACObserve(self.viewModel, orderData1);
    RAC(_orderListView2, dataArray) = RACObserve(self.viewModel, orderData2);
    RAC(_orderListView3, dataArray) = RACObserve(self.viewModel, orderData3);
    RAC(_orderListView4, dataArray) = RACObserve(self.viewModel, orderData4);
    RAC(_orderListView0, dataArray) = RACObserve(self.viewModel, orderData0);
}

- (void)handleEvent
{
    WS(ws);
    
    [_scrollView addOrderListBackScrollViewBlock:^(NSInteger index) {
        
        ws.stateSelectView.index = [NSNumber numberWithInteger:index];
        
    }];
    
    [RACObserve(_stateSelectView, index) subscribeNext:^(NSNumber *x) {
        
        if(x)
        {
            NSInteger value = (x.integerValue+1)%5;
            
            ws.viewModel.orderType = [NSNumber numberWithInteger:value];
            
            ws.scrollView.index = x.integerValue;
        }
        
    }];
    
    
    
    [RACObserve(self.viewModel, orderType) subscribeNext:^(NSNumber *x) {
        
        //[ws visitNetworkToGetOrderList];
        
        if(x && ws.viewModel.isWord==NO)
        {
            if([DBManager getInstance].isLogin)
            {
                if(x.integerValue==0)
                {
                    ws.defaultView0.hidden = YES;
                    [ws.orderListView0.header beginRefreshing];
                }
                else if(x.integerValue==1)
                {
                    ws.defaultView1.hidden = YES;
                    [ws.orderListView1.header beginRefreshing];
                }
                else if(x.integerValue==2)
                {
                    ws.defaultView2.hidden = YES;
                    [ws.orderListView2.header beginRefreshing];
                }
                else if(x.integerValue==3)
                {
                    ws.defaultView3.hidden = YES;
                    [ws.orderListView3.header beginRefreshing];
                }
                else if(x.integerValue==4)
                {
                    ws.defaultView4.hidden = YES;
                    [ws.orderListView4.header beginRefreshing];
                }
            }
            else
            {
                if(x.integerValue==0)
                {
                    ws.viewModel.orderData0 = nil;
                    ws.defaultView0.hidden = NO;
                }
                else if(x.integerValue==1)
                {
                    ws.viewModel.orderData1 = nil;
                    ws.defaultView1.hidden = NO;
                }
                else if(x.integerValue==2)
                {
                    ws.viewModel.orderData2 = nil;
                    ws.defaultView2.hidden = NO;
                }
                else if(x.integerValue==3)
                {
                    ws.viewModel.orderData3 = nil;
                    ws.defaultView3.hidden = NO;
                }
                else if(x.integerValue==4)
                {
                    ws.viewModel.orderData4 = nil;
                    ws.defaultView4.hidden = NO;
                }
            }
        }
        
    }];
    
    
    
    
    [_orderListView0 addOrderListViewSelectItemBlock:^(OrderListView *view, CheckinOrderListModel *model, NSIndexPath *indexPath) {
        
        OrderDetailViewModel *viewModel = [[OrderDetailViewModel alloc] init];
        viewModel.checkinId = model.checkinId;
        PushVCWithVM(OrderDetailViewController, viewModel);
        
    } refreshBlock:^(MJRefreshNormalHeader *headerView) {
        
        if([DBManager getInstance].isLogin)
        {
            [[ws.viewModel.commandGetOrderData0 execute:nil] subscribeNext:^(NSString *x) {
                
                [headerView endRefreshing];
                
                if(x && x.length)
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:x];
                }
                else
                {
                    if(ws.viewModel.orderData0.count==0)
                    {
                        ws.defaultView0.hidden = NO;
                        ws.defaultView0.type = DefaultViewNoOrder;
                        ws.defaultView0.frame = CGRectMake(MAIN_SCREEN_WIDTH*4, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
                        ws.defaultView0.button.tag = 101;
                        [ws.defaultView0.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    else
                    {
                        ws.defaultView0.hidden = YES;
                    }
                    
                    if(ws.viewModel.orderData0.count>=ws.viewModel.totalElements0.integerValue)
                    {
                        ws.orderListView0.footer.hidden = YES;
                    }
                    else
                    {
                        ws.orderListView0.footer.hidden = NO;
                    }
                }
                
            }];
        }
        else
        {
            ws.viewModel.orderData0 = nil;
            [headerView endRefreshing];
            ws.defaultView0.hidden = NO;
        }
        
    } loadmoreBlock:^(MJRefreshAutoStateFooter *footerView) {
        
        [[ws.viewModel.commandGetMoreOrderData0 execute:nil] subscribeNext:^(NSString *x) {
            
            [footerView endRefreshing];
            
            if(x && x.length)
            {
                [[UIApplication sharedApplication].keyWindow makeToast:x];
            }
            else
            {
                if(ws.viewModel.orderData0.count>=ws.viewModel.totalElements0.integerValue)
                {
                    ws.orderListView0.footer.hidden = YES;
                }
                else
                {
                    ws.orderListView0.footer.hidden = NO;
                }
            }
            
        }];
        
    }];
    
    [_orderListView1 addOrderListViewSelectItemBlock:^(OrderListView *view, CheckinOrderListModel *model, NSIndexPath *indexPath) {
        
        OrderDetailViewModel *viewModel = [[OrderDetailViewModel alloc] init];
        viewModel.checkinId = model.checkinId;
        PushVCWithVM(OrderDetailViewController, viewModel);
        
    } refreshBlock:^(MJRefreshNormalHeader *headerView) {
        
        if([DBManager getInstance].isLogin)
        {
            [[ws.viewModel.commandGetOrderData1 execute:nil] subscribeNext:^(NSString *x) {
                
                [headerView endRefreshing];
                
                if(x && x.length)
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:x];
                }
                else
                {
                    if(ws.viewModel.orderData1.count==0)
                    {
                        ws.defaultView1.hidden = NO;
                        ws.defaultView1.type = DefaultViewNoOrder;
                        ws.defaultView1.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
                        ws.defaultView1.button.tag = 101;
                        [ws.defaultView1.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    else
                    {
                        ws.defaultView1.hidden = YES;
                    }
                    
                    if(ws.viewModel.orderData1.count>=ws.viewModel.totalElements1.integerValue)
                    {
                        ws.orderListView1.footer.hidden = YES;
                    }
                    else
                    {
                        ws.orderListView1.footer.hidden = NO;
                    }
                }
                
            }];
        }
        else
        {
            ws.viewModel.orderData1 = nil;
            [headerView endRefreshing];
            ws.defaultView1.hidden = NO;
        }
        
    } loadmoreBlock:^(MJRefreshAutoStateFooter *footerView) {
        
        [[ws.viewModel.commandGetMoreOrderData1 execute:nil] subscribeNext:^(NSString *x) {
            
            [footerView endRefreshing];
            
            if(x && x.length)
            {
                [[UIApplication sharedApplication].keyWindow makeToast:x];
            }
            else
            {
                if(ws.viewModel.orderData1.count>=ws.viewModel.totalElements1.integerValue)
                {
                    ws.orderListView1.footer.hidden = YES;
                }
                else
                {
                    ws.orderListView1.footer.hidden = NO;
                }
            }
            
        }];
        
    }];
    
    [_orderListView2 addOrderListViewSelectItemBlock:^(OrderListView *view, CheckinOrderListModel *model, NSIndexPath *indexPath) {
        
        OrderDetailViewModel *viewModel = [[OrderDetailViewModel alloc] init];
        viewModel.checkinId = model.checkinId;
        PushVCWithVM(OrderDetailViewController, viewModel);
        
    } refreshBlock:^(MJRefreshNormalHeader *headerView) {
        
        if([DBManager getInstance].isLogin)
        {
            [[ws.viewModel.commandGetOrderData2 execute:nil] subscribeNext:^(NSString *x) {
                
                [headerView endRefreshing];
                
                if(x && x.length)
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:x];
                }
                else
                {
                    if(ws.viewModel.orderData2.count==0)
                    {
                        ws.defaultView2.hidden = NO;
                        ws.defaultView2.type = DefaultViewNoOrder;
                        ws.defaultView2.frame = CGRectMake(MAIN_SCREEN_WIDTH*1, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
                        ws.defaultView2.button.tag = 101;
                        [ws.defaultView2.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    else
                    {
                        ws.defaultView2.hidden = YES;
                    }
                    
                    if(ws.viewModel.orderData2.count>=ws.viewModel.totalElements2.integerValue)
                    {
                        ws.orderListView2.footer.hidden = YES;
                    }
                    else
                    {
                        ws.orderListView2.footer.hidden = NO;
                    }
                }
                
            }];
        }
        else
        {
            ws.viewModel.orderData2 = nil;
            [headerView endRefreshing];
            ws.defaultView2.hidden = NO;
        }
        
    } loadmoreBlock:^(MJRefreshAutoStateFooter *footerView) {
        
        [[ws.viewModel.commandGetMoreOrderData2 execute:nil] subscribeNext:^(NSString *x) {
            
            [footerView endRefreshing];
            
            if(x && x.length)
            {
                [[UIApplication sharedApplication].keyWindow makeToast:x];
            }
            else
            {
                if(ws.viewModel.orderData2.count>=ws.viewModel.totalElements2.integerValue)
                {
                    ws.orderListView2.footer.hidden = YES;
                }
                else
                {
                    ws.orderListView2.footer.hidden = NO;
                }
            }
            
        }];
        
    }];
    
    [_orderListView3 addOrderListViewSelectItemBlock:^(OrderListView *view, CheckinOrderListModel *model, NSIndexPath *indexPath) {
        
        OrderDetailViewModel *viewModel = [[OrderDetailViewModel alloc] init];
        viewModel.checkinId = model.checkinId;
        PushVCWithVM(OrderDetailViewController, viewModel);
        
    } refreshBlock:^(MJRefreshNormalHeader *headerView) {
        
        if([DBManager getInstance].isLogin)
        {
            [[ws.viewModel.commandGetOrderData3 execute:nil] subscribeNext:^(NSString *x) {
                
                [headerView endRefreshing];
                
                if(x && x.length)
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:x];
                }
                else
                {
                    if(ws.viewModel.orderData3.count==0)
                    {
                        ws.defaultView3.hidden = NO;
                        ws.defaultView3.type = DefaultViewNoOrder;
                        ws.defaultView3.frame = CGRectMake(MAIN_SCREEN_WIDTH*2, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
                        ws.defaultView3.button.tag = 101;
                        [ws.defaultView3.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    else
                    {
                        ws.defaultView3.hidden = YES;
                    }
                    
                    if(ws.viewModel.orderData3.count>=ws.viewModel.totalElements3.integerValue)
                    {
                        ws.orderListView3.footer.hidden = YES;
                    }
                    else
                    {
                        ws.orderListView3.footer.hidden = NO;
                    }
                }
                
            }];
        }
        else
        {
            ws.viewModel.orderData3 = nil;
            [headerView endRefreshing];
            ws.defaultView3.hidden = NO;
        }
        
    } loadmoreBlock:^(MJRefreshAutoStateFooter *footerView) {
        
        [[ws.viewModel.commandGetMoreOrderData3 execute:nil] subscribeNext:^(NSString *x) {
            
            [footerView endRefreshing];
            
            if(x && x.length)
            {
                [[UIApplication sharedApplication].keyWindow makeToast:x];
            }
            else
            {
                if(ws.viewModel.orderData3.count>=ws.viewModel.totalElements3.integerValue)
                {
                    ws.orderListView3.footer.hidden = YES;
                }
                else
                {
                    ws.orderListView3.footer.hidden = NO;
                }
            }
            
        }];
        
    }];
    
    [_orderListView4 addOrderListViewSelectItemBlock:^(OrderListView *view, CheckinOrderListModel *model, NSIndexPath *indexPath) {
        
        OrderDetailViewModel *viewModel = [[OrderDetailViewModel alloc] init];
        viewModel.checkinId = model.checkinId;
        PushVCWithVM(OrderDetailViewController, viewModel);
        
    } refreshBlock:^(MJRefreshNormalHeader *headerView) {
        
        if([DBManager getInstance].isLogin)
        {
            [[ws.viewModel.commandGetOrderData4 execute:nil] subscribeNext:^(NSString *x) {
                
                [headerView endRefreshing];
                
                if(x && x.length)
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:x];
                }
                else
                {
                    if(ws.viewModel.orderData4.count==0)
                    {
                        ws.defaultView4.hidden = NO;
                        ws.defaultView4.type = DefaultViewNoOrder;
                        ws.defaultView4.frame = CGRectMake(MAIN_SCREEN_WIDTH*3, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
                        ws.defaultView4.button.tag = 101;
                        [ws.defaultView4.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    else
                    {
                        ws.defaultView4.hidden = YES;
                    }
                    
                    if(ws.viewModel.orderData4.count>=ws.viewModel.totalElements4.integerValue)
                    {
                        ws.orderListView4.footer.hidden = YES;
                    }
                    else
                    {
                        ws.orderListView4.footer.hidden = NO;
                    }
                }
                
            }];
        }
        else
        {
            ws.viewModel.orderData4 = nil;
            [headerView endRefreshing];
            ws.defaultView4.hidden = NO;
        }
        
    } loadmoreBlock:^(MJRefreshAutoStateFooter *footerView) {
        
        [[ws.viewModel.commandGetMoreOrderData4 execute:nil] subscribeNext:^(NSString *x) {
            
            [footerView endRefreshing];
            
            if(x && x.length)
            {
                [[UIApplication sharedApplication].keyWindow makeToast:x];
            }
            else
            {
                if(ws.viewModel.orderData4.count>=ws.viewModel.totalElements4.integerValue)
                {
                    ws.orderListView4.footer.hidden = YES;
                }
                else
                {
                    ws.orderListView4.footer.hidden = NO;
                }
            }
            
        }];
        
    }];
    
}


- (void)visitNetworkToGetOrderList
{
    WS(ws);
    
    if([DBManager getInstance].isLogin)
    {
        if(self.viewModel.orderType)
        {
            if(self.viewModel.orderType.integerValue==0)
            {
                [[ws.viewModel.commandGetOrderData0 execute:nil] subscribeNext:^(NSString *x) {
                    
                    if(x && x.length)
                    {
                        [[UIApplication sharedApplication].keyWindow makeToast:x];
                    }
                    else
                    {
                        if(ws.viewModel.orderData0.count==0)
                        {
                            ws.defaultView0.hidden = NO;
                            ws.defaultView0.type = DefaultViewNoOrder;
                            ws.defaultView0.frame = CGRectMake(MAIN_SCREEN_WIDTH*4, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
                            ws.defaultView0.button.tag = 101;
                            [ws.defaultView0.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        else
                        {
                            ws.defaultView0.hidden = YES;
                        }
                        
                        
                        if(ws.viewModel.orderData0.count>=ws.viewModel.totalElements0.integerValue)
                        {
                            ws.orderListView0.footer.hidden = YES;
                        }
                        else
                        {
                            ws.orderListView0.footer.hidden = NO;
                        }
                    }
                }];
            }
            else if(self.viewModel.orderType.integerValue==1)
            {
                [[ws.viewModel.commandGetOrderData1 execute:nil] subscribeNext:^(NSString *x) {
                    
                    if(x && x.length)
                    {
                        [[UIApplication sharedApplication].keyWindow makeToast:x];
                    }
                    else
                    {
                        if(ws.viewModel.orderData1.count==0)
                        {
                            ws.defaultView1.hidden = NO;
                            ws.defaultView1.type = DefaultViewNoOrder;
                            ws.defaultView1.frame = CGRectMake(MAIN_SCREEN_WIDTH*0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
                            ws.defaultView1.button.tag = 101;
                            [ws.defaultView1.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        else
                        {
                            ws.defaultView1.hidden = YES;
                        }
                        
                        
                        if(ws.viewModel.orderData1.count>=ws.viewModel.totalElements1.integerValue)
                        {
                            ws.orderListView1.footer.hidden = YES;
                        }
                        else
                        {
                            ws.orderListView1.footer.hidden = NO;
                        }
                    }
                }];
            }
            else if(self.viewModel.orderType.integerValue==2)
            {
                [[ws.viewModel.commandGetOrderData2 execute:nil] subscribeNext:^(NSString *x) {
                    
                    if(x && x.length)
                    {
                        [[UIApplication sharedApplication].keyWindow makeToast:x];
                    }
                    else
                    {
                        if(ws.viewModel.orderData2.count==0)
                        {
                            ws.defaultView2.hidden = NO;
                            ws.defaultView2.type = DefaultViewNoOrder;
                            ws.defaultView2.frame = CGRectMake(MAIN_SCREEN_WIDTH*1, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
                            ws.defaultView2.button.tag = 101;
                            [ws.defaultView2.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        else
                        {
                            ws.defaultView2.hidden = YES;
                        }
                        
                        
                        if(ws.viewModel.orderData2.count>=ws.viewModel.totalElements2.integerValue)
                        {
                            ws.orderListView2.footer.hidden = YES;
                        }
                        else
                        {
                            ws.orderListView2.footer.hidden = NO;
                        }
                    }
                }];
            }
            else if(self.viewModel.orderType.integerValue==3)
            {
                [[ws.viewModel.commandGetOrderData3 execute:nil] subscribeNext:^(NSString *x) {
                    
                    if(x && x.length)
                    {
                        [[UIApplication sharedApplication].keyWindow makeToast:x];
                    }
                    else
                    {
                        if(ws.viewModel.orderData3.count==0)
                        {
                            ws.defaultView3.hidden = NO;
                            ws.defaultView3.type = DefaultViewNoOrder;
                            ws.defaultView3.frame = CGRectMake(MAIN_SCREEN_WIDTH*2, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
                            ws.defaultView3.button.tag = 101;
                            [ws.defaultView3.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        else
                        {
                            ws.defaultView3.hidden = YES;
                        }
                        
                        
                        if(ws.viewModel.orderData3.count>=ws.viewModel.totalElements3.integerValue)
                        {
                            ws.orderListView3.footer.hidden = YES;
                        }
                        else
                        {
                            ws.orderListView3.footer.hidden = NO;
                        }
                    }
                }];
            }
            else if(self.viewModel.orderType.integerValue==4)
            {
                [[ws.viewModel.commandGetOrderData4 execute:nil] subscribeNext:^(NSString *x) {
                    
                    if(x && x.length)
                    {
                        [[UIApplication sharedApplication].keyWindow makeToast:x];
                    }
                    else
                    {
                        if(ws.viewModel.orderData4.count==0)
                        {
                            ws.defaultView4.hidden = NO;
                            ws.defaultView4.type = DefaultViewNoOrder;
                            ws.defaultView4.frame = CGRectMake(MAIN_SCREEN_WIDTH*3, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-49);
                            ws.defaultView4.button.tag = 101;
                            [ws.defaultView4.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                        }
                        else
                        {
                            ws.defaultView4.hidden = YES;
                        }
                        
                        
                        if(ws.viewModel.orderData4.count>=ws.viewModel.totalElements4.integerValue)
                        {
                            ws.orderListView4.footer.hidden = YES;
                        }
                        else
                        {
                            ws.orderListView4.footer.hidden = NO;
                        }
                    }
                }];
            }
        }
        
    }
}


- (void)defaultViewButtonAction:(UIButton *)button
{
    if(button.tag==100)
    {
        PresentVC(LoginViewController);
    }
    else if(button.tag==101)
    {
        [CustomTabBarController getInstance].index = TabBarIndexHome;
    }
}







- (DefaultView *)defaultView0
{
    if(_defaultView0==nil)
    {
        _defaultView0 = [[DefaultView alloc] init];
        [_scrollView addSubview:_defaultView0];
    }
    
    return _defaultView0;
}
- (DefaultView *)defaultView1
{
    if(_defaultView1==nil)
    {
        _defaultView1 = [[DefaultView alloc] init];
        [_scrollView addSubview:_defaultView1];
    }
    
    return _defaultView1;
}
- (DefaultView *)defaultView2
{
    if(_defaultView2==nil)
    {
        _defaultView2 = [[DefaultView alloc] init];
        [_scrollView addSubview:_defaultView2];
    }
    
    return _defaultView2;
}
- (DefaultView *)defaultView3
{
    if(_defaultView3==nil)
    {
        _defaultView3 = [[DefaultView alloc] init];
        [_scrollView addSubview:_defaultView3];
    }
    
    return _defaultView3;
}
- (DefaultView *)defaultView4
{
    if(_defaultView4==nil)
    {
        _defaultView4 = [[DefaultView alloc] init];
        [_scrollView addSubview:_defaultView4];
    }
    
    return _defaultView4;
}


- (OrderListViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[OrderListViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
