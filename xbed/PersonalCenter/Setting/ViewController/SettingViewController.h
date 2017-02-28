//
//  SettingViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "SettingViewmodel.h"
#import "NormalTableCell.h"
#import "SimpleTableCell.h"

@interface SettingViewController : XbedViewController

@property (nonatomic, strong)SettingViewModel *viewModel;

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)NormalTableCell *cellAbout;
@property (nonatomic, strong, readonly)NormalTableCell *cellAppStore;
@property (nonatomic, strong, readonly)SimpleTableCell *btnLogout;
@property (nonatomic, strong)STAlertView *alertView;

@end
