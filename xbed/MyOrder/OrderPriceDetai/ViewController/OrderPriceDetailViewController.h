//
//  OrderPriceDetailViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/9/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  订单价格详情

#import "XbedViewController.h"
#import "OrderPriceDetailViewModel.h"
#import "OrderPriceDetailListView.h"

@interface OrderPriceDetailViewController : XbedViewController

@property (nonatomic, strong, readonly)OrderPriceDetailListView *listView;

@property (nonatomic, strong)OrderPriceDetailViewModel *viewModel;

@end
