//
//  OrderListViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "OrderListViewModel.h"
#import "OrderListBackScrollView.h"
#import "OrderListStateSelectView.h"
#import "OrderListView.h"
#import "DefaultView.h"

@interface OrderListViewController : XbedViewController

@property (nonatomic, strong, readonly)OrderListBackScrollView *scrollView;

@property (nonatomic, strong, readonly)OrderListStateSelectView *stateSelectView;
@property (nonatomic, strong, readonly)OrderListView *orderListView0;//全部
@property (nonatomic, strong, readonly)OrderListView *orderListView1;//待支付
@property (nonatomic, strong, readonly)OrderListView *orderListView3;//待入住
@property (nonatomic, strong, readonly)OrderListView *orderListView2;//已入住
@property (nonatomic, strong, readonly)OrderListView *orderListView4;//待评价
@property (nonatomic, strong, readonly)DefaultView *defaultView0;
@property (nonatomic, strong, readonly)DefaultView *defaultView1;
@property (nonatomic, strong, readonly)DefaultView *defaultView2;
@property (nonatomic, strong, readonly)DefaultView *defaultView3;
@property (nonatomic, strong, readonly)DefaultView *defaultView4;

@property (nonatomic, strong)STAlertView *alertView;

@property (nonatomic, strong)OrderListViewModel *viewModel;

@end
