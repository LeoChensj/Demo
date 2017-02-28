//
//  RubbishHomePageViewController.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "RubbishHomePageViewModel.h"
#import "HomeMainRefresh.h"
#import "HomePageBanner.h"
#import "HomePageSelectView.h"
#import "HomeMainAdvertView2.h"

@interface RubbishHomePageViewController : XbedViewController

@property (nonatomic, strong)RubbishHomePageViewModel *viewModel;

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)HomeMainRefresh *refresh;
@property (nonatomic, strong, readonly)HomePageBanner *banner;
@property (nonatomic, strong, readonly)HomePageSelectView *selectView;
@property (nonatomic, strong, readonly)HomeMainAdvertView2 *advertView;


@end
