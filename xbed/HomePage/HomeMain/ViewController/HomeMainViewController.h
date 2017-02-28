//
//  HomeMainViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  首页

#import "XbedViewController.h"
#import "HomeMainRefresh.h"
#import "HomeMainNavigationView.h"
#import "HomeMainBanner.h"
#import "HomeMainAdvertView1.h"
#import "HomeMainAdvertView2.h"
#import "HomeMainCityHeadView.h"
#import "HomeMainCityTableView.h"
#import "HomemainviewModel.h"


@interface HomeMainViewController : XbedViewController

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)HomeMainRefresh *refresh;
@property (nonatomic, strong, readonly)HomeMainBanner *banner;
@property (nonatomic, strong, readonly)HomeMainNavigationView *navgationView;
@property (nonatomic, strong, readonly)HomeMainAdvertView1 *advertView1;
@property (nonatomic, strong, readonly)HomeMainCityHeadView *cityHeadView;
@property (nonatomic, strong, readonly)HomeMainCityTableView *cityTableView;
@property (nonatomic, strong, readonly)HomeMainAdvertView2 *advertView2;

@property (nonatomic, strong)HomeMainViewModel *viewModel;

@end
