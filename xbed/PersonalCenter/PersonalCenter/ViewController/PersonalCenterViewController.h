//
//  PersonalCenterViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "PersonalCenterViewModel.h"
#import "PersonalCenterBaseInfoView.h"
#import "PersonalCenterTableView.h"

@interface PersonalCenterViewController : XbedViewController

@property (nonatomic, strong, readonly)PersonalCenterBaseInfoView *baseInfoView;
@property (nonatomic, strong, readonly)PersonalCenterTableView *tableView;

@property (nonatomic, strong)PersonalCenterViewModel *viewModel;

@end
