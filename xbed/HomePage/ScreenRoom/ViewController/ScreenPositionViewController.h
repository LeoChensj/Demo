//
//  ScreenPositionViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  筛选位置

#import "XbedViewController.h"
#import "ScreenRoomViewModel.h"
#import "PositionSelectView.h"

@interface ScreenPositionViewController : XbedViewController

@property (nonatomic, strong, readonly)PositionSelectView *positionSelectView;

@property (nonatomic, strong)ScreenRoomViewModel *viewModel;

@end
