//
//  CalendarView1.h
//  xbed
//
//  Created by Leo.Chen on 16/7/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  不带价格  可选

#import <UIKit/UIKit.h>
#import "WeekView.h"
#import "CalendarCollectionView1.h"

@interface CalendarView1 : UIView
{
@private
    WeekView *_vWeek;
    CalendarCollectionView1 *_collectionView;
}

@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;

- (instancetype)initWithToday:(NSDate *)today;
- (void)addCalendarView1SelectCompleteBlock:(CalendarCollectionView1SelectCompleteBlock)block;

@end
