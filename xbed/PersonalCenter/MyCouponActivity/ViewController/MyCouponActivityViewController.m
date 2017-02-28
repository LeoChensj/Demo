//
//  MyCouponActivityViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyCouponActivityViewController.h"

@implementation MyCouponActivityViewController

@synthesize defaultView = _defaultView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    [IQKeyboardManager sharedManager].enable = NO;
//}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"优惠券";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _inputView = [[MyCouponActivityInputView alloc] init];
    [self.view addSubview:_inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(10);
        //make.bottom.mas_equalTo(_listView.mas_top).offset(-25);
        make.top.mas_equalTo(64+20);
        
    }];
    
    
    _listView = [[MyCouponActivityListView alloc] init];
    [self.view addSubview:_listView];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-(64+20+45));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64+20+45);
        
    }];
    
}

- (void)bindViewModel
{
    RAC(self.viewModel, code) = RACObserve(_inputView, code);
    RAC(_inputView.btnExchange, enabled) = self.viewModel.signalExchange;
    
    
    RAC(_listView, dataArray) = RACObserve(self.viewModel, couponData);
}

- (void)handleEvent
{
    WS(ws);
    [[self.viewModel.commandGetData execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [ws.view makeToast:x];
        }
        else
        {
            if(ws.viewModel.couponData.count<=0 ||
               (ws.viewModel.couponData.count==1 && ws.viewModel.couponData[0].count<=0) ||
               (ws.viewModel.couponData.count>=2 && ws.viewModel.couponData[0].count<=0 && ws.viewModel.couponData[1].count<=0))
            {
                ws.defaultView.hidden = NO;
                ws.defaultView.type = DefaultViewNoCoupon;
                ws.defaultView.frame = CGRectMake(0, 64+90, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64-90);
            }
            else
            {
                ws.defaultView.hidden = YES;
            }
        }
        
    }];
    
    [[_inputView.btnExchange rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"兑换");
        
        [ws.view endEditing:YES];
        
        [[ws.viewModel.commandExchange execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)
            {
                [ws.view makeToast:x];
            }
            else
            {
                ws.defaultView.hidden = YES;
                
                STAlertView *alertView = [[STAlertView alloc] initWithTitle:@"兑换成功" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
                [alertView show];
            }
            
        }];
        
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

- (MyCouponActivityViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[MyCouponActivityViewModel alloc] init];
    }
    
    return _viewModel;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
