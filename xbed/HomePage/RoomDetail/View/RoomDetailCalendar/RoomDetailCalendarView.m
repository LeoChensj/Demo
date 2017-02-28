//
//  RoomDetailCalendarView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailCalendarView.h"

@implementation RoomDetailCalendarView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _monthSelectView = [[MonthSelectView alloc] init];
        [self addSubview:_monthSelectView];
        [_monthSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(24);
            make.top.mas_equalTo(25);
            make.left.mas_equalTo(0);
            
        }];
        
        
        WS(ws);
        [[_monthSelectView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws.monthSelectView subMonth];
            [ws.scrollView setContentOffset:CGPointMake(ws.scrollView.contentOffset.x-MAIN_SCREEN_WIDTH, 0) animated:YES];
            
        }];
        
        [[_monthSelectView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws.monthSelectView addMonth];
            [ws.scrollView setContentOffset:CGPointMake(ws.scrollView.contentOffset.x+MAIN_SCREEN_WIDTH, 0) animated:YES];
            
        }];
        
        
        
        _vWeek = [[WeekView alloc] init];
        _vWeek.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vWeek];
        [_vWeek mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_monthSelectView.mas_bottom).offset(10);
            
        }];
        
        NSInteger width_7 = (NSInteger)(MAIN_SCREEN_WIDTH/7);
        NSInteger heightCell = width_7-5;
        _heightCollection = heightCell*6+5*5+10;
        
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH*3, _heightCollection);
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(_heightCollection);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_vWeek.mas_bottom).offset(0);
            
        }];
        
        
        _calendarCollectionView1 = [[CalendarCollectionView2 alloc] init];
        [_scrollView addSubview:_calendarCollectionView1];
        [_calendarCollectionView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(_heightCollection);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        _calendarCollectionView2 = [[CalendarCollectionView2 alloc] init];
        [_scrollView addSubview:_calendarCollectionView2];
        [_calendarCollectionView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(_heightCollection);
            make.left.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.top.mas_equalTo(0);
            
        }];
        
        _calendarCollectionView3 = [[CalendarCollectionView2 alloc] init];
        [_scrollView addSubview:_calendarCollectionView3];
        [_calendarCollectionView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(_heightCollection);
            make.left.mas_equalTo(MAIN_SCREEN_WIDTH*2);
            make.top.mas_equalTo(0);
            
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}




- (void)setToday:(NSDate *)today
{
    _today = today;
    
    _monthSelectView.today = today;
    _calendarCollectionView1.today = today;
    _calendarCollectionView2.today = today;
    _calendarCollectionView3.today = today;
    
    _calendarHandle = [[CalendarHandle alloc] initWithToday:today];
}
- (void)setRoomStatus:(NSArray<RoomDetailRoomStatusModel *> *)roomStatus
{
    _roomStatus = roomStatus;
    
    if(roomStatus && roomStatus.count>0)
    {
        self.hidden = NO;
        
        _dataArray = [_calendarHandle handle2WithRoomStatus:roomStatus];
        
        _calendarCollectionView1.dataArray = _dataArray[0];
        _calendarCollectionView2.dataArray = _dataArray[1];
        _calendarCollectionView3.dataArray = _dataArray[2];
    }
    else
    {
        self.hidden = YES;
    }
}


#pragma mark - Helper




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/MAIN_SCREEN_WIDTH;
    
    _monthSelectView.currentDate = [[_monthSelectView.today dateMonthStart] dateByAddingMonth:index];
}





@end
