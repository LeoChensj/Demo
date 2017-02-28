//
//  HomePageCalendarViewController.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "RubbishHomePageViewModel.h"
#import "CalendarView1.h"

@interface HomePageCalendarViewController : XbedViewController

@property (nonatomic, strong, readonly)CalendarView1 *calendarView;

@property (nonatomic, strong)RubbishHomePageViewModel *viewModel;

@end
