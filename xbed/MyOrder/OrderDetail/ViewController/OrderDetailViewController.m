//
//  OrderDetailViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderPriceDetailViewController.h"
#import "RoomDetailViewController.h"
#import "RoomAddressViewController.h"
#import "ApplyCleanViewController.h"
#import "NetworkOpenDoorViewController.h"
#import "CheckinInfoConfirmViewController.h"
#import "FeedbackViewController.h"
#import "ShareOrderView.h"
#import "CheckinInfoConfirmViewController.h"
#import "WebViewController.h"
#import "CleanEvaluateViewController.h"
#import "PayMethodSelectView.h"
#import "LeoTouchIdManager.h"
#import "FaceVerificationStep1ViewController.h"
#import "OrderDetailAddCheckinPersonViewController.h"
#import "RoomEvaluateViewController.h"

@implementation OrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"订单详情";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
    
    [self.headView.btnRight mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
    }];
}

- (void)setupView
{
    _scrollView = [[OrderDetailScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
}

- (void)bindViewModel
{
    WS(ws);
    @weakify(self);
    
    RAC(self.priceView, actualPrice) = RACObserve(self.viewModel, actualPrice);//计算价格
    RAC(self.viewModel, isMyselfCheckin) = RACObserve(self.checkinPersonView, isMyself);
    
    [RACObserve(self.viewModel, isMyselfCheckin) subscribeNext:^(NSNumber *x) {
        
        @strongify(self);
        
        if(x.boolValue)//选中本人入住
        {
            if([DBManager getInstance].loginModel.isIdentity.boolValue==NO)//未身份验证
            {
                ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"对不起，您还没有进行身份验证，无法办理入住" cancelButtonTitle:@"取消" otherButtonTitle:@"去验证" cancelButtonBlock:^{
                    
                    ws.checkinPersonView.swtMyself.on = NO;
                    
                } otherButtonBlock:^{
                    
                    ws.checkinPersonView.swtMyself.on = NO;
                    
                    //验证成功 打开本人入住
                    [RACObserve([DBManager getInstance].loginModel, isIdentity) subscribeNext:^(NSNumber *x) {
                        
                        if(x.boolValue)
                        {
                            ws.checkinPersonView.swtMyself.on = YES;
                        }
                        
                    }];
                    
                    FaceVerificationViewModel *viewModel = [[FaceVerificationViewModel alloc] init];
                    viewModel.loginModel = [[DBManager getInstance].loginModel copy];
                    PushVCWithVM(FaceVerificationStep1ViewController, viewModel);
                    
                }];
                [ws.alertView show];
            }
        }
        
    }];
    
    
    [RACObserve(self.viewModel, checkinOrderInfo) subscribeNext:^(CheckinOrderInfoDataModel *x) {
        
        if(x && x.type)
        {
            for (UIView *view in ws.scrollView.subviews)
            {
                if(![view isKindOfClass:[MJRefreshNormalHeader class]])
                {
                    [view removeFromSuperview];
                }
            }
            [ws.btnHandle removeFromSuperview];
            
            
            switch (x.type.integerValue)
            {
                case 0:
                {
                    ws.headView.txtRight = @"";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.orderStateView];
                    [ws.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.orderStateView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(0);
                        
                    }];
                    ws.orderStateView.orderType = x.type;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderStateView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    [ws.scrollView addSubview:ws.priceView];
                    [ws.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        //make.height.mas_equalTo(ws.priceView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomInfoView.mas_bottom).offset(10);
                        
                    }];
                    ws.priceView.rentType = ws.viewModel.checkinOrderInfo.rentType.integerValue-1;
                    ws.priceView.payInfo = x.payInfo;
                    ws.priceView.orderType = x.type;
                    
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.priceView.mas_bottom).offset(0);
                        
                    }];
                    
                    
                    
                    ws.btnHandle.title = @"重新预订";
                    ws.btnHandle.enabled = YES;
                    [ws.view addSubview:ws.btnHandle];
                    [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(49);
                        make.left.bottom.mas_equalTo(0);
                        
                    }];
                    
                    
                    break;
                }
                case 1:
                {
                    ws.headView.txtRight = @"取消订单";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.orderStateView];
                    [ws.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.orderStateView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(0);
                        
                    }];
                    ws.orderStateView.orderType = x.type;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderStateView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    [ws.scrollView addSubview:ws.priceView];
                    [ws.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.priceView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomInfoView.mas_bottom).offset(10);
                        
                    }];
                    ws.priceView.rentType = ws.viewModel.checkinOrderInfo.rentType.integerValue-1;
                    ws.priceView.payInfo = x.payInfo;
                    ws.priceView.orderType = x.type;
                    ws.priceView.actualPrice = ws.viewModel.actualPrice;
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.priceView.mas_bottom).offset(0);
                        
                    }];
                    
                    
                    if(ws.viewModel.checkinOrderInfo.source.integerValue==1)//去呼呼的订单不支持支付和取消
                    {
                        ws.btnHandle.title = @"暂不支持其他渠道订单的支付和取消";
                        ws.btnHandle.enabled = NO;
                        [ws.view addSubview:ws.btnHandle];
                        [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                            make.height.mas_equalTo(49);
                            make.left.bottom.mas_equalTo(0);
                            
                        }];
                    }
                    else
                    {
                        ws.btnHandle.title = @"支付订单";
                        ws.btnHandle.enabled = YES;
                        [ws.view addSubview:ws.btnHandle];
                        [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                            make.height.mas_equalTo(49);
                            make.left.bottom.mas_equalTo(0);
                            
                        }];
                    }
                        
                    
                    

                    break;
                }
                case 2:
                {
                    ws.headView.txtRight = @"常见问题";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.orderStateView];
                    [ws.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.orderStateView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(0);
                        
                    }];
                    ws.orderStateView.orderType = x.type;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderStateView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    [ws.scrollView addSubview:ws.checkinPersonView];
                    [ws.checkinPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.checkinPersonView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomInfoView.mas_bottom).offset(0);
                        
                    }];
                    ws.checkinPersonView.checkinerType = x.checkinerType;
                    ws.checkinPersonView.sharers = x.checkinerList;
                    
                    [ws.scrollView addSubview:ws.remindView];
                    [ws.remindView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(0);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.checkinPersonView.mas_bottom).offset(10);
                        
                    }];
                    ws.remindView.remindArray = x.roomInfo.remind;
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.remindView.mas_bottom).offset(0);
                        
                    }];
                    
                    
                    
                    ws.btnHandle.title = @"打扫中，如需办理入住，请联系客服";
                    ws.btnHandle.enabled = NO;
                    [ws.view addSubview:ws.btnHandle];
                    [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(49);
                        make.left.bottom.mas_equalTo(0);
                        
                    }];

                    break;
                }
                case 3:
                {
                    ws.headView.txtRight = @"常见问题";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.orderStateView];
                    [ws.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.orderStateView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(0);
                        
                    }];
                    ws.orderStateView.orderType = x.type;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderStateView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    [ws.scrollView addSubview:ws.checkinPersonView];
                    [ws.checkinPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.checkinPersonView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomInfoView.mas_bottom).offset(0);
                        
                    }];
                    ws.checkinPersonView.checkinerType = x.checkinerType;
                    ws.checkinPersonView.sharers = x.checkinerList;
                    
                    [ws.scrollView addSubview:ws.remindView];
                    [ws.remindView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(0);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.checkinPersonView.mas_bottom).offset(10);
                        
                    }];
                    ws.remindView.remindArray = x.roomInfo.remind;
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.remindView.mas_bottom).offset(0);
                        
                    }];
                    
                    
                    
                    ws.btnHandle.title = @"请于入住当天14:00后办理入住，提前会告知";
                    ws.btnHandle.enabled = NO;
                    [ws.view addSubview:ws.btnHandle];
                    [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(49);
                        make.left.bottom.mas_equalTo(0);
                        
                    }];

                    break;
                }
                case 4:
                {
                    ws.headView.txtRight = @"常见问题";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.orderStateView];
                    [ws.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.orderStateView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(0);
                        
                    }];
                    ws.orderStateView.orderType = x.type;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderStateView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    [ws.scrollView addSubview:ws.checkinPersonView];
                    [ws.checkinPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.checkinPersonView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomInfoView.mas_bottom).offset(0);
                        
                    }];
                    ws.checkinPersonView.checkinerType = x.checkinerType;
                    ws.checkinPersonView.sharers = x.checkinerList;
                    
                    [ws.scrollView addSubview:ws.remindView];
                    [ws.remindView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(0);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.checkinPersonView.mas_bottom).offset(10);
                        
                    }];
                    ws.remindView.remindArray = x.roomInfo.remind;
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.remindView.mas_bottom).offset(0);
                        
                    }];
                    
                    
                    
                    ws.btnHandle.title = @"办理入住";
                    ws.btnHandle.enabled = YES;
                    [ws.view addSubview:ws.btnHandle];
                    [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(49);
                        make.left.bottom.mas_equalTo(0);
                        
                    }];
                    
                    break;
                }
                case 5:
                {
                    ws.headView.txtRight = @"常见问题";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.orderStateView];
                    [ws.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.orderStateView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(0);
                        
                    }];
                    ws.orderStateView.orderType = x.type;
                    
                    [ws.scrollView addSubview:ws.belowLineVerifyView];
                    [ws.belowLineVerifyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.belowLineVerifyView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderStateView.mas_bottom).offset(10);
                        
                    }];
                    ws.belowLineVerifyView.phone = ws.viewModel.checkinOrderInfo.contactPhone;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.belowLineVerifyView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    [ws.scrollView addSubview:ws.checkinPersonView];
                    [ws.checkinPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.checkinPersonView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomInfoView.mas_bottom).offset(0);
                        
                    }];
                    ws.checkinPersonView.checkinerType = x.checkinerType;
                    ws.checkinPersonView.sharers = x.checkinerList;
                    
                    [ws.scrollView addSubview:ws.remindView];
                    [ws.remindView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(0);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.checkinPersonView.mas_bottom).offset(10);
                        
                    }];
                    ws.remindView.remindArray = x.roomInfo.remind;
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.remindView.mas_bottom).offset(0);
                        
                    }];
                    

                    break;
                }
                case 6:
                {
                    ws.headView.txtRight = @"常见问题";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.orderStateView];
                    [ws.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.orderStateView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(0);
                        
                    }];
                    ws.orderStateView.orderType = x.type;
                    
                    [ws.scrollView addSubview:ws.belowLineVerifyView];
                    [ws.belowLineVerifyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.belowLineVerifyView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderStateView.mas_bottom).offset(10);
                        
                    }];
                    ws.belowLineVerifyView.phone = ws.viewModel.checkinOrderInfo.contactPhone;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.belowLineVerifyView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    [ws.scrollView addSubview:ws.checkinPersonView];
                    [ws.checkinPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.checkinPersonView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomInfoView.mas_bottom).offset(0);
                        
                    }];
                    ws.checkinPersonView.checkinerType = x.checkinerType;
                    ws.checkinPersonView.sharers = x.checkinerList;
                    
                    [ws.scrollView addSubview:ws.remindView];
                    [ws.remindView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(0);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.checkinPersonView.mas_bottom).offset(10);
                        
                    }];
                    ws.remindView.remindArray = x.roomInfo.remind;
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.remindView.mas_bottom).offset(0);
                        
                    }];
                    
                    break;
                }
                case 7:
                {
                    if(ws.viewModel.checkinOrderInfo.checkinerType.integerValue==-1)
                    {
                        ws.headView.txtRight = @"添加入住人";
                    }
                    else
                    {
                        ws.headView.txtRight = @"常见问题";
                    }
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.orderStateView];
                    [ws.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.orderStateView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(0);
                        
                    }];
                    ws.orderStateView.orderType = x.type;
                    
                    [ws.scrollView addSubview:ws.openDoorPwdView];
                    [ws.openDoorPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.openDoorPwdView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderStateView.mas_bottom).offset(10);
                        
                    }];
                    ws.openDoorPwdView.password = x.checkinOrderInfo.openPwd;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.openDoorPwdView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    [ws.scrollView addSubview:ws.roomServiceView];
                    [ws.roomServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomServiceView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomInfoView.mas_bottom).offset(10);
                        
                    }];
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.roomServiceView.mas_bottom).offset(0);
                        
                    }];
                    
                    
                    
                    ws.btnHandle.title = @"办理退房";
                    ws.btnHandle.enabled = YES;
                    [ws.view addSubview:ws.btnHandle];
                    [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(49);
                        make.left.bottom.mas_equalTo(0);
                        
                    }];
                    
                    
                    
                    
                    
                    if(ws.viewModel.checkinOrderInfo.checkinerType.integerValue!=-1 && [DBManager getInstance].loginModel.isIdentity.boolValue==NO)//非主入住人且没有身份验证
                    {
                        ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"您还没有进行身份验证，是否去验证？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" cancelButtonBlock:^{
                            
                            [ws back];
                            
                        } otherButtonBlock:^{
                            
                            FaceVerificationViewModel *viewModel = [[FaceVerificationViewModel alloc] init];
                            viewModel.loginModel = [[DBManager getInstance].loginModel copy];
                            FaceVerificationStep1ViewController *vc = [[FaceVerificationStep1ViewController alloc] init];
                            vc.viewModel = viewModel;
                            
                            NSMutableArray *tempVC = [NSMutableArray arrayWithArray:[RootViewController getInstance].viewControllers];
                            [tempVC removeLastObject];
                            [tempVC addObject:vc];
                            
                            [[RootViewController getInstance] setViewControllers:tempVC animated:YES];
                            
                        }];
                        [ws.alertView show];
                    }
                    

                    break;
                }
                case 8:
                {
                    ws.headView.txtRight = @"";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.roomInfoView.mas_bottom).offset(0);
                        
                    }];
                    
                    
                    ws.btnHandle.title = @"立即评价";
                    ws.btnHandle.enabled = YES;
                    [ws.view addSubview:ws.btnHandle];
                    [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(49);
                        make.left.bottom.mas_equalTo(0);
                        
                    }];
                    

                    break;
                }
                case 9:
                {
                    ws.headView.txtRight = @"";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    
                    
                    
                    
                    
                    
                    [ws.scrollView addSubview:ws.roomStarView];
                    [ws.roomStarView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(92);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomInfoView.mas_bottom).offset(0);
                        
                    }];
                    ws.roomStarView.title = @"房间评分";
                    ws.roomStarView.enable = NO;
                    ws.roomStarView.star = ws.viewModel.checkinOrderInfo.evaluated.roomStar;
                    ws.roomStarView.termList = ws.viewModel.checkinOrderInfo.evaluated.roomTermList;
                    
                    [ws.scrollView addSubview:ws.cleanStarView];
                    [ws.cleanStarView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(92+30);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomStarView.mas_bottom).offset(0);
                        
                    }];
                    ws.cleanStarView.title = @"清洁评分";
                    ws.cleanStarView.enable = NO;
                    ws.cleanStarView.star = ws.viewModel.checkinOrderInfo.evaluated.cleanStar;
                    ws.cleanStarView.termList = ws.viewModel.checkinOrderInfo.evaluated.cleanTermList;
                    
                    [ws.scrollView addSubview:ws.evaluateContentView];
                    [ws.evaluateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(0);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.cleanStarView.mas_bottom).offset(0);
                        
                    }];
                    ws.evaluateContentView.content = ws.viewModel.checkinOrderInfo.evaluated.content;
                    
                    [ws.scrollView addSubview:ws.evaluatedPhotoView];
                    [ws.evaluatedPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(0);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.evaluateContentView.mas_bottom).offset(0);
                        
                    }];
                    ws.evaluatedPhotoView.dataArray = ws.viewModel.checkinOrderInfo.evaluated.picList;
                    
                    [ws.scrollView addSubview:ws.nearbyRoomView];
                    [ws.nearbyRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(70+((MAIN_SCREEN_WIDTH-96)*2/3)+98);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.evaluatedPhotoView.mas_bottom).offset(10);
                        
                    }];
                    ws.nearbyRoomView.dataArray = ws.viewModel.nearbyRoomData;
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.nearbyRoomView.mas_bottom).offset(0);
                        
                    }];
                    
                    
                    ws.btnHandle.title = @"再次预订";
                    ws.btnHandle.enabled = YES;
                    [ws.view addSubview:ws.btnHandle];
                    [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(49);
                        make.left.bottom.mas_equalTo(0);
                        
                    }];
                    
                    break;
                }
                case 10:
                {
                    ws.headView.txtRight = @"";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    
                    [ws.scrollView addSubview:ws.evaluateOverdueStarView];
                    [ws.evaluateOverdueStarView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(163);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.roomInfoView.mas_bottom).offset(10);
                        
                    }];
                    
                    [ws.scrollView addSubview:ws.nearbyRoomView];
                    [ws.nearbyRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(0);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.evaluateOverdueStarView.mas_bottom).offset(10);
                        
                    }];
                    ws.nearbyRoomView.dataArray = ws.viewModel.nearbyRoomData;
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.nearbyRoomView.mas_bottom).offset(0);
                        
                    }];
                    
                    
                    
                    ws.btnHandle.title = @"再次预订";
                    ws.btnHandle.enabled = YES;
                    [ws.view addSubview:ws.btnHandle];
                    [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(49);
                        make.left.bottom.mas_equalTo(0);
                        
                    }];
                    
                    break;
                }
                    
                case -1:
                {
                    ws.headView.txtRight = @"";
                    
                    [ws.scrollView addSubview:ws.orderNoView];
                    [ws.orderNoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(44);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(0);
                        
                    }];
                    ws.orderNoView.orderType = x.type;
                    ws.orderNoView.orderNo = x.checkinOrderInfo.orderNo;
                    
                    [ws.scrollView addSubview:ws.orderStateView];
                    [ws.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.orderStateView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderNoView.mas_bottom).offset(0);
                        
                    }];
                    ws.orderStateView.orderType = x.type;
                    
                    [ws.scrollView addSubview:ws.roomInfoView];
                    [ws.roomInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(ws.roomInfoView.myHeight);
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(ws.orderStateView.mas_bottom).offset(10);
                        
                    }];
                    ws.roomInfoView.orderType = x.type;
                    ws.roomInfoView.roomInfo = x.roomInfo;
                    ws.roomInfoView.checkinInfo = x.checkinOrderInfo;
                    
                    
                    [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                        
                        make.bottom.mas_equalTo(ws.roomInfoView.mas_bottom).offset(0);
                        
                    }];
                    
                    
                    
                    ws.btnHandle.title = @"联系客服";
                    ws.btnHandle.enabled = YES;
                    [ws.view addSubview:ws.btnHandle];
                    [ws.btnHandle mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                        make.height.mas_equalTo(49);
                        make.left.bottom.mas_equalTo(0);
                        
                    }];
                    
                    break;
                }
                    
                default:
                    break;
            }
            
            
        }
        
    }];
    
}

- (void)handleEvent
{
    WS(ws);
    
    [[self.viewModel.commandGetOrderDetailData execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [ws.view makeToast:x];
        }
        
    }];
    
    
    //刷新
    [_scrollView addOrderDetailScrollViewRefreshBlock:^(MJRefreshNormalHeader *header) {
        
        [[ws.viewModel.commandGetOrderDetailData execute:nil] subscribeNext:^(NSString *x) {
            
            [header endRefreshing];
            
            if(x && x.length)
            {
                [ws.view makeToast:x];
            }
            
        }];
        
    }];
    
    
    [[self.headView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSNumber *orderType = ws.viewModel.checkinOrderInfo.type;
        
        if(orderType)
        {
            //if(orderType.integerValue==1 || orderType.integerValue==2 || orderType.integerValue==3 || orderType.integerValue==4 || orderType.integerValue==5 || orderType.integerValue==6)
            if(orderType.integerValue==1)
            {
                if(ws.viewModel.cancleCheckinOrderFlag==NO)
                {
                    NSLog(@"取消订单");
                    
                    ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"确定要取消该订单吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" cancelButtonBlock:nil otherButtonBlock:^{
                        
                        [[ws.viewModel.commandCancleCheckinOrder execute:nil] subscribeNext:^(NSString *x) {
                            
                            if(x && x.length)
                            {
                                [ws.view makeToast:x];
                            }
                            else
                            {
                                if(ws.viewModel.cancleCheckinOrderFlag==YES)
                                {
                                    ws.headView.txtRight = @"常见问题";
                                    [ws.view makeToast:@"已经有人办理了入住，订单不能取消"];
                                }
                            }
                            
                        }];
                        
                    }];
                    [ws.alertView show];
                    
                }
                else
                {
                    NSLog(@"常见问题");
                    
                    WebViewController *webVC = [[WebViewController alloc] init];
                    webVC.url = [NSString stringWithFormat:@"%@/fqa/ios", URL_Web];
                    [[RootViewController getInstance] pushViewController:webVC animated:YES];
                }
            }
            else if(orderType.integerValue==2 || orderType.integerValue==3 || orderType.integerValue==4 || orderType.integerValue==5 || orderType.integerValue==6)
            {
                NSLog(@"常见问题");
                
                WebViewController *webVC = [[WebViewController alloc] init];
                webVC.url = [NSString stringWithFormat:@"%@/fqa/ios", URL_Web];
                [[RootViewController getInstance] pushViewController:webVC animated:YES];
            }
            else if(orderType.integerValue==7)
            {
                NSLog(@"共享订单");
                
                if(ws.viewModel.checkinOrderInfo.checkinerType.integerValue==-1)
                {
                    OrderDetailAddCheckinPersonViewController *vc = [[OrderDetailAddCheckinPersonViewController alloc] init];
                    vc.viewModel = ws.viewModel;
                    [[RootViewController getInstance] pushViewController:vc animated:YES];
                }
                else
                {
                    WebViewController *webVC = [[WebViewController alloc] init];
                    webVC.url = [NSString stringWithFormat:@"%@/fqa/ios", URL_Web];
                    [[RootViewController getInstance] pushViewController:webVC animated:YES];
                }
            }
            
        }
        
        
    }];
    
}



#pragma mark - View Get
- (OrderDetailOrderNoView *)orderNoView
{
    if(_orderNoView==nil)
    {
        _orderNoView = [[OrderDetailOrderNoView alloc] init];
        
        WS(ws);
        @weakify(self);
        [[_orderNoView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"订单价格详情");
            
            @strongify(self);
            OrderPriceDetailViewModel *viewModel = [[OrderPriceDetailViewModel alloc] init];
            viewModel.rentType = ws.viewModel.checkinOrderInfo.rentType.integerValue-1;
            viewModel.payInfo = ws.viewModel.checkinOrderInfo.payInfo;
            viewModel.actualPrice = ws.viewModel.actualPrice;
            PresentVCWithVM(OrderPriceDetailViewController, viewModel);
            
        }];
    }
    
    return _orderNoView;
}
- (OrderDetailOrderStateView *)orderStateView
{
    if(_orderStateView==nil)
    {
        _orderStateView = [[OrderDetailOrderStateView alloc] init];
    }
    
    return _orderStateView;
}
- (OrderDetailRoomInfoView *)roomInfoView
{
    if(_roomInfoView==nil)
    {
        _roomInfoView = [[OrderDetailRoomInfoView alloc] init];
        
        WS(ws);
        [[_roomInfoView.btnRoomInfo rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"房间详情");
            
            if(ws.viewModel.checkinOrderInfo.roomInfo.flag.integerValue==1)
            {
                RoomDetailViewModel *viewModel = [[RoomDetailViewModel alloc] init];
                viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                viewModel.rentType = ws.viewModel.checkinOrderInfo.rentType.integerValue-1;
                PushVCWithVM(RoomDetailViewController, viewModel);
            }
            else
            {
                ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"对不起，该房间已下架" cancelButtonTitle:@"知道了" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
                [ws.alertView show];
            }
            
        }];
        
        [[_roomInfoView.btnRoomAddress rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"房间地址");
            
            if(ws.viewModel.checkinOrderInfo.roomInfo.flag.integerValue==1)
            {
                RoomAddressViewModel *viewModel = [[RoomAddressViewModel alloc] init];
                viewModel.longitude = ws.viewModel.checkinOrderInfo.roomInfo.longitude;
                viewModel.latitude = ws.viewModel.checkinOrderInfo.roomInfo.latitude;
                viewModel.address = ws.viewModel.checkinOrderInfo.roomInfo.custRoomAddr;
                viewModel.parkInfo = ws.viewModel.checkinOrderInfo.roomInfo.traffic;
                if(ws.viewModel.checkinOrderInfo.roomInfo.naviPic && ws.viewModel.checkinOrderInfo.roomInfo.naviPic.count)
                {
                    viewModel.imageNavigation = ws.viewModel.checkinOrderInfo.roomInfo.naviPic[0];
                }
                PushVCWithVM(RoomAddressViewController, viewModel);
            }
            else
            {
                ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"对不起，该房间已下架" cancelButtonTitle:@"知道了" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
                [ws.alertView show];
            }
            
        }];
        
    }
    
    return _roomInfoView;
}
- (OrderDetailOpenDoorPwdView *)openDoorPwdView
{
    if(_openDoorPwdView==nil)
    {
        _openDoorPwdView = [[OrderDetailOpenDoorPwdView alloc] init];
    }
    
    return _openDoorPwdView;
}
- (OrderDetailBelowLineVerifyView *)belowLineVerifyView
{
    if(_belowLineVerifyView==nil)
    {
        _belowLineVerifyView = [[OrderDetailBelowLineVerifyView alloc] init];
    }
    
    return _belowLineVerifyView;
}
- (OrderDetailCheckinPersonView *)checkinPersonView
{
    if(_checkinPersonView==nil)
    {
        _checkinPersonView = [[OrderDetailCheckinPersonView alloc] init];
        
        WS(ws);
        [[_checkinPersonView.btnAddCheckinPerson rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"添加入住人");
            
            NSString* strUrl = ws.viewModel.checkinOrderInfo.roomInfo.picture;
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:strUrl]];
            SDImageCache* cache = [SDImageCache sharedImageCache];
            UIImage *roomImage = [cache imageFromDiskCacheForKey:key];
            
            ShareOrderView *shareOrderView = [[ShareOrderView alloc] init];
            shareOrderView.viewController = ws;
            shareOrderView.image = roomImage;
            shareOrderView.desc = ws.viewModel.checkinOrderInfo.roomInfo.custRoomName;
            shareOrderView.url = ws.viewModel.checkinOrderInfo.shareUrl;
            [shareOrderView show];
            
        }];
    }
    
    return _checkinPersonView;
}
- (OrderDetailPriceView *)priceView
{
    if(_priceView==nil)
    {
        _priceView = [[OrderDetailPriceView alloc] init];
    }
    
    return _priceView;
}
- (OrderDetailRemindView *)remindView
{
    if(_remindView==nil)
    {
        _remindView = [[OrderDetailRemindView alloc] init];
    }
    
    return _remindView;
}
- (OrderDetailRoomServiceView *)roomServiceView
{
    if(_roomServiceView==nil)
    {
        _roomServiceView = [[OrderDetailRoomServiceView alloc] init];
        
        WS(ws);
        
        [[_roomServiceView.cellClean rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"申请清洁");
            
            [[ws.viewModel.commandCheckinClean execute:nil] subscribeNext:^(NSString *x) {
                
                if(x && x.length)
                {
                    [ws.view makeToast:x];
                }
                else
                {
                    if(ws.viewModel.checkinCleanInfo.type.integerValue==1)//可申请在住清洁
                    {
                        ApplyCleanViewModel *viewModel = [[ApplyCleanViewModel alloc] init];
                        viewModel.todayData = ws.viewModel.checkinCleanInfo.cleanTime.today;
                        viewModel.tomorrowData = ws.viewModel.checkinCleanInfo.cleanTime.tomorrow;
                        viewModel.checkinId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.checkinId;
                        viewModel.orderNo = ws.viewModel.checkinOrderInfo.checkinOrderInfo.orderNo;
                        viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                        PushVCWithVM(ApplyCleanViewController, viewModel);
                    }
                    else if(ws.viewModel.checkinCleanInfo.type.integerValue==2)//已经申请了在住清洁单，是否取消
                    {
                        ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"您已经申请了在住清洁，再次申请需取消上一单，确定取消吗？" cancelButtonTitle:@"关闭" otherButtonTitle:@"确定" cancelButtonBlock:nil otherButtonBlock:^{
                            
                            [[ws.viewModel.commandCancleCleanAndCleanTime execute:nil] subscribeNext:^(NSString *x) {
                                
                                if(x && x.length)//取消清洁单失败
                                {
                                    [ws.view makeToast:x];
                                }
                                else//取消清洁单成功
                                {
                                    ApplyCleanViewModel *viewModel = [[ApplyCleanViewModel alloc] init];
                                    viewModel.todayData = ws.viewModel.checkinCleanInfo.cleanTime.today;
                                    viewModel.tomorrowData = ws.viewModel.checkinCleanInfo.cleanTime.tomorrow;
                                    viewModel.checkinId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.checkinId;
                                    viewModel.orderNo = ws.viewModel.checkinOrderInfo.checkinOrderInfo.orderNo;
                                    viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                                    PushVCWithVM(ApplyCleanViewController, viewModel);
                                }
                                
                            }];
                            
                        }];
                        [ws.alertView show];
                    }
                    else if(ws.viewModel.checkinCleanInfo.type.integerValue==3)//要在住清洁评价
                    {
                        CleanEvaluateViewModel *viewModel = [[CleanEvaluateViewModel alloc] init];
                        viewModel.checkinId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.checkinId;
                        viewModel.orderNo = ws.viewModel.checkinOrderInfo.checkinOrderInfo.orderNo;
                        viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                        viewModel.cleanEvaluationData = ws.viewModel.checkinCleanInfo.cleanEvaluation;
                        PushVCWithVM(CleanEvaluateViewController, viewModel);
                    }
                }
                
            }];
            
            
        }];
        
        [[_roomServiceView.cellWifi rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"wifi密码");
            
            NSString *msgWiFi = [NSString stringWithFormat:@"Wi-Fi账号：Xbed******(*为任意数字)\nWi-Fi密码：%@", Wifi_Password];
            
            ws.alertView = [[STAlertView alloc] initWithTitle:@"Wi-Fi信息" message:msgWiFi cancelButtonTitle:@"取消" otherButtonTitle:@"复制密码" cancelButtonBlock:nil otherButtonBlock:^{
                
                [UIPasteboard generalPasteboard].string = Wifi_Password;
                
            }];
            [ws.alertView show];
            
        }];
        
        @weakify(self);
        [[_roomServiceView.cellDoor rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            @strongify(self);
            NSLog(@"网络开门");
            
            if([LeoTouchIdManager canTouchId])
            {
                [LeoTouchIdManager startWithMessage:@"通过Home键验证已有手机指纹" fallbackTitle:@"验证码开门" success:^{
                    
                    NSLog(@"touchId验证成功");
                    
                    [[ws.viewModel.commendOpenDoor execute:nil] subscribeNext:^(NSString *x) {
                        
                        if(x && x.length)
                        {
                            //[ws.view makeToast:x];
                            ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"指纹开门失败，是否选择验证码方式开门？" cancelButtonTitle:@"取消" otherButtonTitle:@"验证码开门" cancelButtonBlock:nil otherButtonBlock:^{
                                
                                NetworkOpenDoorViewModel *viewModel = [[NetworkOpenDoorViewModel alloc] init];
                                viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                                PresentVCWithVM(NetworkOpenDoorViewController, viewModel);
                                
                            }];
                            [ws.alertView show];
                        }
                        else
                        {
                            ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"网络开门成功，门锁发出提示声后即可开门！" cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
                            [ws.alertView show];

                        }
                        
                    }];
                    
                } failureBlock:^(LAError code) {
                    
                    if(code==LAErrorUserCancel)
                    {
                        NSLog(@"用户取消");
                    }
                    else if(code==LAErrorUserFallback)
                    {
                        NSLog(@"选择其他验证方式");
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            NetworkOpenDoorViewModel *viewModel = [[NetworkOpenDoorViewModel alloc] init];
                            viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                            PresentVCWithVM(NetworkOpenDoorViewController, viewModel);
                            
                        });
                        
                    }
                    
                }];
                
            }
            else
            {
                NetworkOpenDoorViewModel *viewModel = [[NetworkOpenDoorViewModel alloc] init];
                viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                PresentVCWithVM(NetworkOpenDoorViewController, viewModel);
            }
            
        }];
        
        [[_roomServiceView.cellCheckin rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"办理续住");
            
//            [[ws.viewModel.commandVerifyOverstay execute:nil] subscribeNext:^(NSString *x) {
//                
//                if(x && x.length)
//                {
//                    [ws.view makeToast:x];
//                }
//                else
//                {
//                    if(ws.viewModel.overstayFlag)//可以办理续住
//                    {
//                        CheckinInfoConfirmViewModel *viewModel = [[CheckinInfoConfirmViewModel alloc] init];
//                        viewModel.type = 1;
//                        viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
//                        viewModel.roomImage = ws.viewModel.checkinOrderInfo.roomInfo.picture;
//                        viewModel.title = ws.viewModel.checkinOrderInfo.roomInfo.custRoomName;
//                        viewModel.roomType = ws.viewModel.checkinOrderInfo.roomInfo.houseType;
//                        viewModel.person = ws.viewModel.checkinOrderInfo.roomInfo.liveCount;
//                        viewModel.checkinDate = [CalendarHandle dateHandle2:ws.viewModel.checkinOrderInfo.checkinOrderInfo.checkoutDate];
//                        viewModel.checkinId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.checkinId;
//                        PushVCWithVM(CheckinInfoConfirmViewController, viewModel);
//                    }
//                    else//不能办理续住
//                    {
//                        [ws.view makeToast:@"不能办理续住"];
//                    }
//                }
//                
//            }];
            
            ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"系统升级中，如您需要续住，请前往预订页预订" cancelButtonTitle:@"取消" otherButtonTitle:@"立即前往" cancelButtonBlock:nil otherButtonBlock:^{
                
                CheckinInfoConfirmViewModel *viewModel = [[CheckinInfoConfirmViewModel alloc] init];
                viewModel.rentType = ws.viewModel.checkinOrderInfo.rentType.integerValue-1;
                viewModel.type = 0;
                viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                viewModel.roomImage = ws.viewModel.checkinOrderInfo.roomInfo.picture;
                viewModel.title = ws.viewModel.checkinOrderInfo.roomInfo.custRoomName;
                viewModel.roomType = ws.viewModel.checkinOrderInfo.roomInfo.houseType;
                viewModel.person = ws.viewModel.checkinOrderInfo.roomInfo.liveCount;
                PushVCWithVM(CheckinInfoConfirmViewController, viewModel);
                
            }];
            [ws.alertView show];
            
        }];
        
        [[_roomServiceView.cellOpinion rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"意见反馈");
            
            PushVC(FeedbackViewController, YES);
            
        }];
        
        [[_roomServiceView.cellEvaluate rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"房间评价");
            
            RoomEvaluateViewModel *viewModel = [[RoomEvaluateViewModel alloc] init];
            viewModel.checkinId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.checkinId;
            viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
            viewModel.rentType = ws.viewModel.checkinOrderInfo.rentType;
            viewModel.roomInfo = ws.viewModel.checkinOrderInfo.roomInfo;
            PushVCWithVM(RoomEvaluateViewController, viewModel);
            
        }];
        
    }
    
    return _roomServiceView;
}

- (RoomEvaluateStarView *)roomStarView
{
    if(_roomStarView==nil)
    {
        _roomStarView = [[RoomEvaluateStarView alloc] init];
    }
    
    return _roomStarView;
}
- (RoomEvaluateStarView *)cleanStarView
{
    if(_cleanStarView==nil)
    {
        _cleanStarView = [[RoomEvaluateStarView alloc] init];
    }
    
    return _cleanStarView;
}
- (RoomEvaluateContentView *)evaluateContentView
{
    if(_evaluateContentView==nil)
    {
        _evaluateContentView = [[RoomEvaluateContentView alloc] init];
    }
    
    return _evaluateContentView;
}
- (RoomEvaluatePhotoView *)evaluatedPhotoView
{
    if(_evaluatedPhotoView==nil)
    {
        _evaluatedPhotoView = [[RoomEvaluatePhotoView alloc] init];
    }
    
    return _evaluatedPhotoView;
}
- (RoomDetailNearbyRoomView *)nearbyRoomView
{
    if(_nearbyRoomView==nil)
    {
        _nearbyRoomView = [[RoomDetailNearbyRoomView alloc] init];
        
        [_nearbyRoomView addRoomDetailNearbyRoomViewDidSelectItemBlock:^(RoomDetailNearbyRoomView *view, NearbyRoomModel *model, NSInteger index) {
            
            RoomDetailViewModel *viewModel = [[RoomDetailViewModel alloc] init];
            viewModel.roomId = model.roomId;
            PushVCWithVM(RoomDetailViewController, viewModel);
            
        }];
    }
    
    return _nearbyRoomView;
}
- (EvaluateOverdueStarView *)evaluateOverdueStarView
{
    if(_evaluateOverdueStarView==nil)
    {
        _evaluateOverdueStarView = [[EvaluateOverdueStarView alloc] init];
    }
    
    return _evaluateOverdueStarView;
}




- (BlueButton *)btnHandle
{
    if(_btnHandle==nil)
    {
        _btnHandle = [[BlueButton alloc] init];
        
        WS(ws);
        [[_btnHandle rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if(ws.viewModel.checkinOrderInfo.type.integerValue==0)
            {
                NSLog(@"重新预订");
                
                if(ws.viewModel.checkinOrderInfo.roomInfo.flag.integerValue==1)
                {
                    CheckinInfoConfirmViewModel *viewModel = [[CheckinInfoConfirmViewModel alloc] init];
                    viewModel.type = 0;
                    viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                    viewModel.roomImage = ws.viewModel.checkinOrderInfo.roomInfo.picture;
                    viewModel.title = ws.viewModel.checkinOrderInfo.roomInfo.custRoomName;
                    viewModel.roomType = ws.viewModel.checkinOrderInfo.roomInfo.houseType;
                    viewModel.person = ws.viewModel.checkinOrderInfo.roomInfo.liveCount;
                    PushVCWithVM(CheckinInfoConfirmViewController, viewModel);
                }
                else
                {
                    ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"对不起，该房间已下架" cancelButtonTitle:@"知道了" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
                    [ws.alertView show];
                }
                
            }
            else if(ws.viewModel.checkinOrderInfo.type.integerValue==1)
            {
                NSLog(@"支付订单");
                
                PayMethodSelectView *payView = [[PayMethodSelectView alloc] init];
                [ws.view addSubview:payView];
                [payView show];
                
                [[payView.cellWechat rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                    
                    NSLog(@"微信支付");
                    
                    if([LeoPayManager isWXAppInstalled])
                    {
                        [[ws.viewModel.commendWechatPay execute:nil] subscribeNext:^(NSString *x) {
                            
                            if(x && x.length)//支付失败
                            {
                                [ws.view makeToast:x];
                            }
                            else//支付成功
                            {
                                [ws.view makeToast:@"支付成功"];
                                
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [ws reloadView];
                                    
                                });
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
                            [ws.view makeToast:x];
                        }
                        else//支付成功
                        {
                            [ws.view makeToast:@"支付成功"];
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                [ws reloadView];
                                
                            });
                        }
                        
                    }];
                    
                    [payView close];
                    
                }];
                
            }
            else if(ws.viewModel.checkinOrderInfo.type.integerValue==4)
            {
                NSLog(@"办理入住");
                
                if(ws.viewModel.isMyselfCheckin.boolValue)
                {
                    [[ws.viewModel.commandCheckin execute:nil] subscribeNext:^(NSString *x) {
                        
                        if(x && x.length)
                        {
                            [ws.view makeToast:x];
                        }
                        
                    }];
                }
                else
                {
                    [ws.view makeToast:@"请选择入住人"];
                }
                
                
            }
            else if(ws.viewModel.checkinOrderInfo.type.integerValue==7)
            {
                NSLog(@"办理退房");
                
                ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"确定现在退房吗？" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" cancelButtonBlock:nil otherButtonBlock:^{
                    
                    [[ws.viewModel.commandCheckout execute:nil] subscribeNext:^(NSString *x) {
                        
                        if(x && x.length)
                        {
                            [ws.view makeToast:x];
                        }
                        
                    }];
                    
                }];
                [ws.alertView show];
                
            }
            else if(ws.viewModel.checkinOrderInfo.type.integerValue==8)
            {
                NSLog(@"立即评价");
                
                RoomEvaluateViewModel *viewModel = [[RoomEvaluateViewModel alloc] init];
                viewModel.flag = YES;
                viewModel.checkinId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.checkinId;
                viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                viewModel.rentType = ws.viewModel.checkinOrderInfo.rentType;
                viewModel.roomInfo = ws.viewModel.checkinOrderInfo.roomInfo;
                viewModel.orderDetailViewModel = ws.viewModel;
                PushVCWithVM(RoomEvaluateViewController, viewModel);
                
            }
            else if(ws.viewModel.checkinOrderInfo.type.integerValue==9 ||
                    ws.viewModel.checkinOrderInfo.type.integerValue==10)
            {
                NSLog(@"再次预订");
                
                if(ws.viewModel.checkinOrderInfo.roomInfo.flag.integerValue==1)
                {
                    CheckinInfoConfirmViewModel *viewModel = [[CheckinInfoConfirmViewModel alloc] init];
                    viewModel.rentType = ws.viewModel.checkinOrderInfo.rentType.integerValue-1;
                    viewModel.type = 0;
                    viewModel.roomId = ws.viewModel.checkinOrderInfo.checkinOrderInfo.roomId;
                    viewModel.roomImage = ws.viewModel.checkinOrderInfo.roomInfo.picture;
                    viewModel.title = ws.viewModel.checkinOrderInfo.roomInfo.custRoomName;
                    viewModel.roomType = ws.viewModel.checkinOrderInfo.roomInfo.houseType;
                    viewModel.person = ws.viewModel.checkinOrderInfo.roomInfo.liveCount;
                    PushVCWithVM(CheckinInfoConfirmViewController, viewModel);
                }
                else
                {
                    ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"对不起，该房间已下架" cancelButtonTitle:@"知道了" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
                    [ws.alertView show];
                }
                
            }
            else if(ws.viewModel.checkinOrderInfo.type.integerValue==-1)
            {
                NSLog(@"联系客服");
                
                CallPhone([DBManager getInstance].appUITextData.serviceTelephone);
            }
            
        }];
    }
    
    return _btnHandle;
}

#pragma mark - Help
- (void)reloadView
{
    WS(ws);
    [[self.viewModel.commandGetOrderDetailData execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [ws.view makeToast:x];
        }
        
    }];
}


- (OrderDetailViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[OrderDetailViewModel alloc] init];
    }
    
    return _viewModel;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
