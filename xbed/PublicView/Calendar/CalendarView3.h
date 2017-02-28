//
//  CalendarView3.h
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  带价格 可选

#import <UIKit/UIKit.h>
#import "WeekView.h"
#import "CalendarCollectionView3.h"
#import "RoomStatusRespModel.h"

@interface CalendarView3 : UIView
{
@private
    WeekView *_vWeek;
    CalendarCollectionView3 *_collectionView;
}

@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;
@property (nonatomic, assign)BOOL isOverstay;//是否续住
@property (nonatomic, assign)NSInteger rentType;


- (instancetype)initWithToday:(NSDate *)today roomStatus:(NSArray <RoomDetailRoomStatusModel *>*)roomStatus;
- (void)addCalendarView3SelectCompleteBlock:(CalendarCollectionView3SelectCompleteBlock)block;

@end
