//
//  OrderDetailAddCheckinPersonViewController.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  添加入住人

#import "XbedViewController.h"
#import "OrderDetailViewModel.h"
#import "TouchView.h"
#import "CheckinPersonListView.h"

@interface OrderDetailAddCheckinPersonViewController : XbedViewController

@property (nonatomic, strong)OrderDetailViewModel *viewModel;

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)TouchView *btnAddCheckinPerson;
@property (nonatomic, strong, readonly)CheckinPersonListView *checkinPersonListView;

@end
