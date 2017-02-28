//
//  ScreenCalendarViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  筛选日历 不带价格 可选 控制器

#import "XbedViewController.h"
#import "ScreenRoomViewModel.h"
#import "CalendarView1.h"

@interface ScreenCalendarViewController : XbedViewController

@property (nonatomic, strong, readonly)CalendarView1 *calendarView;

@property (nonatomic, strong)ScreenRoomViewModel *viewModel;

@end
