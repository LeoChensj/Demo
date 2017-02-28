//
//  CouponActivitySelectViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  优惠券 活动选择

#import "XbedViewController.h"
#import "CheckinInfoConfirmViewModel.h"
#import "CouponActivitySegmentedControl.h"
#import "CouponCollectionView.h"
#import "ActivityCollectionView.h"
#import "DefaultView.h"

@interface CouponActivitySelectViewController : XbedViewController

@property (nonatomic, strong, readonly)CouponActivitySegmentedControl *segmentedControl;
@property (nonatomic, strong, readonly)CouponCollectionView *collectionViewCoupon;
@property (nonatomic, strong, readonly)ActivityCollectionView *collectionViewActivity;
@property (nonatomic, strong, readonly)DefaultView *defaultView;


@property (nonatomic, strong)CheckinInfoConfirmViewModel *viewModel;

@end
