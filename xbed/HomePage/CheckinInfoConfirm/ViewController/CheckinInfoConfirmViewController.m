//
//  CheckinInfoConfirmViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinInfoConfirmViewController.h"
#import "CheckinInfoConfirmDateViewController.h"
#import "CouponActivitySelectViewController.h"
#import "PayMethodSelectView.h"
#import "OrderDetailViewController.h"
#import "OrderDetailViewController.h"
#import "ShowAllInfoView.h"

@implementation CheckinInfoConfirmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
    _baseInfoView = [[CheckinInfoConfirmBaseInfoView alloc] init];
    [_scrollView addSubview:_baseInfoView];
    [_baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(134*2/3+20);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        
    }];
    
    
    _dateView = [[CheckinInfoConfirmDateView alloc] init];
    [_scrollView addSubview:_dateView];
    [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(70+34);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_baseInfoView.mas_bottom).offset(10);
        
    }];
    
    
    _couponView = [[CheckinInfoConfirmCouponView alloc] initWithRentType:self.viewModel.rentType];
    [_scrollView addSubview:_couponView];
    [_couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(98);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_dateView.mas_bottom).offset(10);
        
    }];
    
    _wordView = [[CheckinInfoConfirmWordView alloc] init];
    [_scrollView addSubview:_wordView];
    [_wordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_couponView.mas_bottom).offset(10);
        
    }];
    
    
    _orderMoneyView = [[CheckinInfoConfirmOrderMoneyView alloc] initWithRentType:self.viewModel.rentType];
    [_scrollView addSubview:_orderMoneyView];
    [_orderMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(_orderMoneyView.myHeight);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_wordView.mas_bottom).offset(10);
        
    }];
    
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_orderMoneyView.mas_bottom).offset(39+49+10);
        
    }];
    
    
    
    
    _remindView = [[CheckinInfoConfirmRemindView alloc] init];
    [self.view addSubview:_remindView];
    [_remindView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(39);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-49);
        
    }];
    
    _btnPayOrder = [[BlueButton alloc] init];
    _btnPayOrder.title = @"支付订单";
    [self.view addSubview:_btnPayOrder];
    [_btnPayOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        
    }];
    
}

- (void)bindViewModel
{
    WS(ws);
    [RACObserve(self.viewModel, type) subscribeNext:^(NSNumber *x) {
        
        if(x.integerValue==1)//续住信息确认
        {
            ws.headView.title = @"办理续住";
            ws.dateView.checkinDate = ws.viewModel.checkinDate;
        }
        else//普通信息确认
        {
            ws.headView.title = @"确定信息";
        }
        
    }];
    
    
    RAC(_baseInfoView, roomImage) = RACObserve(self.viewModel, roomImage);
    RAC(_baseInfoView, title) = RACObserve(self.viewModel, title);
    RAC(_baseInfoView, roomType) = RACObserve(self.viewModel, roomType);
    RAC(_baseInfoView, person) = RACObserve(self.viewModel, person);
    RAC(_couponView, activityCouponFlag) = RACObserve(self.viewModel, activityCouponFlag);
    RAC(_couponView, selectActivity) = RACObserve(self.viewModel, selectActivity);
    RAC(_couponView, selectCoupon) = RACObserve(self.viewModel, selectCoupon);
    RAC(_couponView, xdollar) = RACObserve(self.viewModel, xdollarEnable);
    RAC(self.viewModel, isWord) = RACObserve(_wordView, isWord);
    RAC(self.viewModel, word) = RACObserve(_wordView, word);
    RAC(self.viewModel, name) = RACObserve(_wordView, name);
    RAC(self.viewModel, phone) = RACObserve(_wordView, phone);
    RAC(self.viewModel, xdollarFlag) = RACObserve(_couponView, xdollarOn);
    RAC(_orderMoneyView, deposit) = RACObserve(self.viewModel, deposit);
    RAC(_orderMoneyView, totalMoney) = RACObserve(self.viewModel, totalMoney);
    RAC(_orderMoneyView, discountMoney) = RACObserve(self.viewModel, discountMoney);
    RAC(_orderMoneyView, actualMoney) = RACObserve(self.viewModel, actualMoney);
    RAC(_btnPayOrder, enabled) = self.viewModel.signalEnablePay;
}

- (void)handleEvent
{
    WS(ws);
    
    [[_dateView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws showCalendar];
        
    }];
    
    [self.viewModel.signalDate subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            ws.dateView.checkinDate = ws.viewModel.checkinDate;
            ws.dateView.checkoutDate = ws.viewModel.checkoutDate;
            
            //取订单数据，计算价格
            [[ws.viewModel.commendGetOrderData execute:nil] subscribeNext:^(NSString *x) {
                
                if(x && x.length>0)
                {
                    //清空订单相关数据
                    ws.dateView.checkinDate = ws.viewModel.checkinDate = nil;
                    ws.dateView.checkoutDate = ws.viewModel.checkoutDate = nil;
                    ws.viewModel.couponData = nil;
                    ws.viewModel.activityData = nil;
                    ws.viewModel.activityCouponFlag = nil;
                    ws.viewModel.selectActivity = nil;
                    ws.viewModel.selectCoupon = nil;
                    ws.viewModel.xdollar = nil;
                    ws.viewModel.xdollarEnable = nil;
                    ws.viewModel.xdollarFlag = nil;
                    ws.viewModel.deposit = nil;
                    ws.viewModel.totalMoney = nil;
                    ws.viewModel.discountMoney = nil;
                    ws.viewModel.discountMoneyNoXdollar = nil;
                    ws.viewModel.actualMoney = nil;
                    ws.viewModel.flag = nil;
                    ws.viewModel.orderNo = nil;
                    ws.viewModel.checkinId = nil;
                    ws.couponView.xdollarOn = nil;
                    
                    
                    [ws.view makeToast:x];
                }
                else
                {
                    if(ws.viewModel.flag.boolValue)//是否0-6点预订当天
                    {
                        [ws showAlertView];
                    }
                    
                    ws.wordView.hidden = NO;
                    ws.couponView.hidden = NO;
                    ws.orderMoneyView.hidden = NO;
                }
                
            }];
            
        }
        else
        {
            ws.wordView.hidden = YES;
            ws.couponView.hidden = YES;
            ws.orderMoneyView.hidden = YES;
        }
        
    }];
    
    
    [[_couponView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        CheckinInfoConfirmViewModel *viewModel = ws.viewModel;
        PushVCWithVM(CouponActivitySelectViewController, viewModel);
        
    }];
    
    //重新计算价格
    [self.viewModel.signalActivityCoupon subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            //取订单数据，重新计算价格
            [[ws.viewModel.commendGetOrderData execute:nil] subscribeNext:^(NSString *x) {
                
                if(x && x.length>0)
                {
                    //清空订单相关数据
                    ws.dateView.checkinDate = ws.viewModel.checkinDate = nil;
                    ws.dateView.checkoutDate = ws.viewModel.checkoutDate = nil;
                    ws.viewModel.couponData = nil;
                    ws.viewModel.activityData = nil;
                    ws.viewModel.activityCouponFlag = nil;
                    ws.viewModel.selectActivity = nil;
                    ws.viewModel.selectCoupon = nil;
                    ws.viewModel.xdollar = nil;
                    ws.viewModel.xdollarEnable = nil;
                    ws.viewModel.xdollarFlag = nil;
                    ws.viewModel.deposit = nil;
                    ws.viewModel.totalMoney = nil;
                    ws.viewModel.discountMoney = nil;
                    ws.viewModel.discountMoneyNoXdollar = nil;
                    ws.viewModel.actualMoney = nil;
                    ws.viewModel.flag = nil;
                    ws.viewModel.orderNo = nil;
                    ws.viewModel.checkinId = nil;
                    ws.couponView.xdollarOn = nil;
                    
                    [ws.view makeToast:x];
                }
                
            }];
        }
        
    }];
    
    
    [RACObserve(_couponView, xdollarOn) subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            NSLog(@"开启");
        }
        else
        {
            NSLog(@"关闭");
        }
        
    }];
    
    
    [[_wordView.btnIsWord rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"是否生成口令");
        
        ShowAllInfoView *infoView = [[ShowAllInfoView alloc] initWithContentHeight:295];
        infoView.title = @"订单口令";
        infoView.contentArray = @[[DBManager getInstance].appUITextData.passwordText];
        [ws.view addSubview:infoView];
        
    }];
    
    
    
    
    [[_btnPayOrder rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"支付订单");
        
        if(ws.viewModel.orderNo.length>0)//已生成订单
        {
            [ws selectPayMethod];
        }
        else//未生成订单
        {
            if(ws.viewModel.type==0)//普通单
            {
                [[ws.viewModel.commendCreateOrder execute:nil] subscribeNext:^(NSString *x) {
                    
                    if(x==nil || x.length<=0)//生成订单成功
                    {
                        [ws selectPayMethod];
                    }
                    else//生成订单失败
                    {
                        [ws.view makeToast:x];
                    }
                    
                }];
            }
            else if(ws.viewModel.type==1)//续住单
            {
                [[ws.viewModel.commendCreateOverstayOrder execute:nil] subscribeNext:^(NSString *x) {
                    
                    if(x==nil || x.length<=0)//生成订单成功
                    {
                        [ws selectPayMethod];
                    }
                    else//生成订单失败
                    {
                        [ws.view makeToast:x];
                    }
                    
                }];
            }
        }
    }];
    
}




#pragma mark - Helper
- (void)showAlertView
{
    WS(ws);
    self.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"凌晨0点－6点预订当天，要求当天12点退房" cancelButtonTitle:@"重新预订" otherButtonTitle:@"知道了" cancelButtonBlock:^{
        
        [ws showCalendar];
        
    } otherButtonBlock:nil];
    [self.alertView show];
}

- (void)showCalendar
{
    WS(ws);
    [[self.viewModel.commendGetCalendarData execute:nil] subscribeNext:^(NSString *x) {
        
        if(x.length)
        {
            [ws.view makeToast:x];
        }
        else
        {
            if(ws.viewModel.roomStatus && ws.viewModel.roomStatus.count>0)
            {
                CheckinInfoConfirmDateViewController *vc = [[CheckinInfoConfirmDateViewController alloc] init];
                vc.viewModel = ws.viewModel;
                [ws presentViewController:vc animated:YES completion:nil];
            }
            else
            {
                NSLog(@"日历没数据");
            }
        }
        
    }];
}



- (void)selectPayMethod
{
    if(self.viewModel.actualMoney.floatValue<=0)
    {
        NSLog(@"支付金额为0，不需要调起支付！");
        [self jumpToOrderDetailVC];
    }
    else
    {
        WS(ws);
        
        PayMethodSelectView *payView = [[PayMethodSelectView alloc] init];
        [self.view addSubview:payView];
        [payView show];
        
        [payView addPayMethodSelectViewCloseBlock:^{
            
            OrderDetailViewModel *viewModel = [[OrderDetailViewModel alloc] init];
            viewModel.checkinId = ws.viewModel.checkinId;
            OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
            vc.viewModel = viewModel;
            
            NSMutableArray *tempVC = [NSMutableArray arrayWithArray:[RootViewController getInstance].viewControllers];
            [tempVC removeLastObject];
            [tempVC addObject:vc];
            
            [[RootViewController getInstance] setViewControllers:tempVC animated:YES];
            
        }];
        
        [[payView.cellWechat rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"微信支付");
            
            if([LeoPayManager isWXAppInstalled])
            {
                [[ws.viewModel.commendWechatPay execute:nil] subscribeNext:^(NSString *x) {
                    
                    if(x && x.length)//支付失败
                    {
                        [[UIApplication sharedApplication].keyWindow makeToast:x];
                        
                        OrderDetailViewModel *viewModel = [[OrderDetailViewModel alloc] init];
                        viewModel.checkinId = ws.viewModel.checkinId;
                        OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
                        vc.viewModel = viewModel;
                        
                        NSMutableArray *tempVC = [NSMutableArray arrayWithArray:[RootViewController getInstance].viewControllers];
                        [tempVC removeLastObject];
                        [tempVC addObject:vc];
                        
                        [[RootViewController getInstance] setViewControllers:tempVC animated:YES];
                        
                    }
                    else//支付成功
                    {
                        [ws.view makeToast:@"支付成功"];
                        [ws jumpToOrderDetailVC];
                    }
                    
                }];
            }
            else
            {
                [[UIApplication sharedApplication].keyWindow makeToast:@"你还没有安装微信，请完成安装后重试"];
            }
            
            [payView close];
            
        }];
        
        
        [[payView.cellUnion rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"银联支付");
            
            [[ws.viewModel.commendUnionPay execute:ws] subscribeNext:^(NSString *x) {
                
                if(x && x.length)//支付失败
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:x];
                    
                    OrderDetailViewModel *viewModel = [[OrderDetailViewModel alloc] init];
                    viewModel.checkinId = ws.viewModel.checkinId;
                    OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
                    vc.viewModel = viewModel;
                    
                    NSMutableArray *tempVC = [NSMutableArray arrayWithArray:[RootViewController getInstance].viewControllers];
                    [tempVC removeLastObject];
                    [tempVC addObject:vc];
                    
                    [[RootViewController getInstance] setViewControllers:tempVC animated:YES];
                }
                else//支付成功
                {
                    [ws.view makeToast:@"支付成功"];
                    [ws jumpToOrderDetailVC];
                }
                
            }];
            
            [payView close];
            
        }];
        
    }
}

- (void)jumpToOrderDetailVC
{
    OrderDetailViewModel *viewModel = [[OrderDetailViewModel alloc] init];
    viewModel.checkinId = self.viewModel.checkinId;
    OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
    vc.viewModel = viewModel;
    
    NSMutableArray *tempVC = [NSMutableArray arrayWithArray:[RootViewController getInstance].viewControllers];
    [tempVC removeLastObject];
    [tempVC addObject:vc];
    
    [[RootViewController getInstance] setViewControllers:tempVC animated:YES];
}









- (CheckinInfoConfirmViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[CheckinInfoConfirmViewModel alloc] init];
    }
    
    return _viewModel;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
