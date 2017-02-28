//
//  CheckinInfoConfirmViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  预订信息确认

#import "XbedViewController.h"
#import "CheckinInfoConfirmViewModel.h"
#import "CheckinInfoConfirmBaseInfoView.h"
#import "CheckinInfoConfirmDateView.h"
#import "CheckinInfoConfirmCouponView.h"
#import "CheckinInfoConfirmWordView.h"
#import "CheckinInfoConfirmOrderMoneyView.h"
#import "CheckinInfoConfirmRemindView.h"
#import "BlueButton.h"

@interface CheckinInfoConfirmViewController : XbedViewController

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)CheckinInfoConfirmBaseInfoView *baseInfoView;
@property (nonatomic, strong, readonly)CheckinInfoConfirmDateView *dateView;
@property (nonatomic, strong, readonly)CheckinInfoConfirmCouponView *couponView;
@property (nonatomic, strong, readonly)CheckinInfoConfirmWordView *wordView;
@property (nonatomic, strong, readonly)CheckinInfoConfirmOrderMoneyView *orderMoneyView;
@property (nonatomic, strong, readonly)CheckinInfoConfirmRemindView *remindView;
@property (nonatomic, strong, readonly)BlueButton *btnPayOrder;
@property (nonatomic, strong)STAlertView *alertView;

@property (nonatomic, strong)CheckinInfoConfirmViewModel *viewModel;

@end
