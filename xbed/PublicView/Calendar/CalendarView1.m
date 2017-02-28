//
//  CalendarView1.m
//  xbed
//
//  Created by Leo.Chen on 16/7/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalendarView1.h"
#import "CalendarHandle.h"

@implementation CalendarView1

- (instancetype)initWithToday:(NSDate *)today
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
        
        
        _collectionView = [[CalendarCollectionView1 alloc] init];
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-44);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(44);
            
        }];
        
        CalendarHandle *handle = [[CalendarHandle alloc] initWithToday:today];
        
        _collectionView.today = handle.today;
        _collectionView.dataArray = [handle handle1];
        
        
        
        RAC(_collectionView, checkinDate) = [RACObserve(self, checkinDate) skip:1];
        RAC(_collectionView, checkoutDate) = [RACObserve(self, checkoutDate) skip:1];
        
    }
    
    return self;
}


- (void)addCalendarView1SelectCompleteBlock:(CalendarCollectionView1SelectCompleteBlock)block
{
    _collectionView.block = block;
}



@end
