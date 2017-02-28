//
//  VillageNavigationViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  小区导航

#import "XbedViewController.h"
#import "VillageNavigationViewModel.h"

@interface VillageNavigationViewController : XbedViewController <UIScrollViewDelegate>

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)UIImageView *imageView;

@property (nonatomic, strong)VillageNavigationViewModel *viewModel;

@end
