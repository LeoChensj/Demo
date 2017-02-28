//
//  MyCouponActivityViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "MyCouponActivityViewModel.h"
#import "MyCouponActivityListView.h"
#import "MyCouponActivityInputView.h"
#import "DefaultView.h"
#import "STAlertView.h"

@interface MyCouponActivityViewController : XbedViewController

@property (nonatomic, strong, readonly)MyCouponActivityListView *listView;
@property (nonatomic, strong, readonly)MyCouponActivityInputView *inputView;
@property (nonatomic, strong, readonly)DefaultView *defaultView;

@property (nonatomic, strong)MyCouponActivityViewModel *viewModel;

@end
