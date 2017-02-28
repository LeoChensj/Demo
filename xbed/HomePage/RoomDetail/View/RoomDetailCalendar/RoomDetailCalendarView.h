//
//  RoomDetailCalendarView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthSelectView.h"
#import "WeekView.h"
#import "CalendarCollectionView2.h"
#import "RoomDetailRespModel.h"

@interface RoomDetailCalendarView : UIView <UIScrollViewDelegate>
{
@private
    WeekView *_vWeek;
    
    CalendarCollectionView2 *_calendarCollectionView1;
    CalendarCollectionView2 *_calendarCollectionView2;
    CalendarCollectionView2 *_calendarCollectionView3;
    
    CalendarHandle *_calendarHandle;
}

@property (nonatomic, strong, readonly)MonthSelectView *monthSelectView;
@property (nonatomic, strong, readonly)UIScrollView *scrollView;

@property (nonatomic, strong, readonly)NSArray <NSArray <DatePriceModel *>*>*dataArray;
@property (nonatomic, assign, readonly)CGFloat heightCollection;

@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSArray <RoomDetailRoomStatusModel *>*roomStatus;

@end
