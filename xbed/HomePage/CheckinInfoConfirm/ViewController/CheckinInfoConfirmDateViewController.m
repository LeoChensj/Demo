//
//  CheckinInfoConfirmDateViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinInfoConfirmDateViewController.h"

@implementation CheckinInfoConfirmDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.imgLeft = @"ic_turn_off";
    self.headView.sizeLeft = CGSizeMake(19, 19);
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

- (void)setupView
{
    NSDate *today;
    if(self.viewModel.roomStatus.count>0)
    {
        today = self.viewModel.roomStatus[0].calendarDate;
    }
    else
    {
        today = [CalendarHandle getToday];
    }
    
    _calendarView = [[CalendarView3 alloc] initWithToday:today roomStatus:self.viewModel.roomStatus];
    if(self.viewModel.type==0)
    {
        _calendarView.isOverstay = NO;
    }
    else if(self.viewModel.type==1)//续住
    {
        _calendarView.isOverstay = YES;
    }
    _calendarView.rentType = self.viewModel.rentType;
    [self.view addSubview:_calendarView];
    [_calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
    _calendarView.checkinDate = self.viewModel.checkinDate;
    _calendarView.checkoutDate = self.viewModel.checkoutDate;
    
    
    WS(ws);
    [_calendarView addCalendarView3SelectCompleteBlock:^(CalendarCollectionView3 *view, NSDate *checkinDate, NSDate *checkoutDate) {
        
        NSLog(@"选好了");
        
        ws.viewModel.checkinDate = checkinDate;
        ws.viewModel.checkoutDate = checkoutDate;
        
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    }];
}




@end
