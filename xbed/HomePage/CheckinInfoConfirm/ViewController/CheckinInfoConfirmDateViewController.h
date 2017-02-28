//
//  CheckinInfoConfirmDateViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "CheckinInfoConfirmViewModel.h"
#import "CalendarView3.h"

@interface CheckinInfoConfirmDateViewController : XbedViewController

@property (nonatomic, strong, readonly)CalendarView3 *calendarView;

@property (nonatomic, strong)CheckinInfoConfirmViewModel *viewModel;

@end
