//
//  CalendarView3.m
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalendarView3.h"

@implementation CalendarView3

- (instancetype)initWithToday:(NSDate *)today roomStatus:(NSArray <RoomDetailRoomStatusModel *>*)roomStatus
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _vWeek = [[WeekView alloc] init];
        [self addSubview:_vWeek];
        [_vWeek mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        
        _collectionView = [[CalendarCollectionView3 alloc] init];
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-44);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(44);
            
        }];
        
        CalendarHandle *handle = [[CalendarHandle alloc] initWithToday:today];
        
        _collectionView.today = handle.today;
        _collectionView.roomStatus = roomStatus;
        _collectionView.dataArray = [handle handle3WithRoomStatus:roomStatus];
    }
    
    return self;
}

- (void)setCheckinDate:(NSDate *)checkinDate
{
    _checkinDate = checkinDate;
    
    _collectionView.checkinDate = checkinDate;
}
- (void)setCheckoutDate:(NSDate *)checkoutDate
{
    _checkoutDate = checkoutDate;
    
    _collectionView.checkoutDate = checkoutDate;
}

- (void)setIsOverstay:(BOOL)isOverstay
{
    _isOverstay = isOverstay;
    
    _collectionView.isOverstay = isOverstay;
}
- (void)setRentType:(NSInteger)rentType
{
    _rentType = rentType;
    
    _collectionView.rentType = rentType;
}


- (void)addCalendarView3SelectCompleteBlock:(CalendarCollectionView3SelectCompleteBlock)block
{
    _collectionView.block = block;
}

@end
