//
//  CouponActivitySelectViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CouponActivitySelectViewController.h"

@implementation CouponActivitySelectViewController

@synthesize defaultView = _defaultView;

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
    
    _segmentedControl = [[CouponActivitySegmentedControl alloc] init];
    [self.headView addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(168);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(26);
        
    }];
    
    if(self.viewModel.activityCouponFlag.integerValue==1)
    {
        _segmentedControl.selectedSegmentIndex = 1;
    }
    else if(self.viewModel.activityCouponFlag.integerValue==2)
    {
        _segmentedControl.selectedSegmentIndex = 0;
    }
}

- (void)setupView
{
    _collectionViewCoupon = [[CouponCollectionView alloc] init];
    _collectionViewCoupon.headTitle = @"以下优惠券不可用";
    _collectionViewCoupon.allowSelect = YES;
    [self.view addSubview:_collectionViewCoupon];
    [_collectionViewCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        
    }];
    
    
    _collectionViewActivity = [[ActivityCollectionView alloc] init];
    [self.view addSubview:_collectionViewActivity];
    [_collectionViewActivity mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        
    }];
}

- (void)bindViewModel
{
    RAC(_collectionViewActivity, dataArray) = RACObserve(self.viewModel, activityData);
    RAC(_collectionViewCoupon, dataArray) = RACObserve(self.viewModel, couponData);
    
    
    if(self.viewModel.activityCouponFlag.integerValue==1)//活动
    {
        _collectionViewCoupon.hidden = YES;
        _collectionViewActivity.hidden = NO;
        
        if(self.viewModel.selectActivity)
        {
            _collectionViewActivity.selectActivity = self.viewModel.selectActivity;
        }
    }
    else if(self.viewModel.activityCouponFlag.integerValue==2)//优惠券
    {
        _collectionViewCoupon.hidden = NO;
        _collectionViewActivity.hidden = YES;
        
        if(self.viewModel.selectCoupon)
        {
            _collectionViewCoupon.selectCoupon = self.viewModel.selectCoupon;
        }
    }
}

- (void)handleEvent
{
    WS(ws);
    
    [RACObserve(_segmentedControl, selectedSegmentIndex) subscribeNext:^(NSNumber *x) {
        
        if(x.integerValue==0)//优惠券
        {
            NSLog(@"切换优惠券");
            
            ws.collectionViewCoupon.hidden = NO;
            ws.collectionViewActivity.hidden = YES;
            
            if(ws.viewModel.couponData.count<=0 ||
               (ws.viewModel.couponData.count==1 && ws.viewModel.couponData[0].count<=0) ||
               (ws.viewModel.couponData.count>=2 && ws.viewModel.couponData[0].count<=0 && ws.viewModel.couponData[1].count<=0))
            {
                ws.defaultView.type = DefaultViewNoCoupon;
                ws.defaultView.hidden = NO;
            }
            else
            {
                ws.defaultView.type = DefaultViewNoCoupon;
                ws.defaultView.hidden = YES;
            }
        }
        else//活动
        {
            NSLog(@"切换活动");
            
            ws.collectionViewCoupon.hidden = YES;
            ws.collectionViewActivity.hidden = NO;
            
            if(ws.viewModel.activityData.count<=0)
            {
                ws.defaultView.type = DefaultViewNoActivity;
                ws.defaultView.hidden = NO;
            }
            else
            {
                ws.defaultView.type = DefaultViewNoActivity;
                ws.defaultView.hidden = YES;
            }
        }
        
    }];
    

    [_collectionViewCoupon addCouponCollectionViewSelectItemBlock:^(CouponCardModel *model, NSInteger index) {
        
        ws.collectionViewActivity.selectActivity = nil;
        
        ws.viewModel.activityCouponFlag = @2;
        ws.viewModel.selectCoupon = model;
        ws.viewModel.selectActivity = nil;
        
        [ws back];
        
    }];
    
    [_collectionViewActivity addActivityCollectionViewSelectItemBlock:^(ActivityContentsModel *model, NSInteger index) {
        
        ws.collectionViewCoupon.selectCoupon = nil;
        
        ws.viewModel.activityCouponFlag = @1;
        ws.viewModel.selectActivity = model;
        ws.viewModel.selectCoupon = nil;
        
        [ws back];
        
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



@end
