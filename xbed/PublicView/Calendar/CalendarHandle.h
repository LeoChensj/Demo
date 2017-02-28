//
//  CalendarHandle.h
//  xbed
//
//  Created by Leo.Chen on 16/7/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatePriceModel.h"
#import "RoomDetailRespModel.h"

@interface CalendarHandle : NSObject

@property (nonatomic, strong, readonly)NSDate *today;//今天
@property (nonatomic, strong, readonly)NSDate *firstMonthDay;//这个月1号
@property (nonatomic, strong, readonly)NSDate *secondMonthDay;//下个月1号
@property (nonatomic, strong, readonly)NSDate *thirdMonthDay;//后个月1号


- (instancetype)initWithToday:(NSDate *)today;//<RoomDetailRoomStatusModel *>*roomStatus

- (NSArray <NSArray <NSDate *>*>*)handle1;
- (NSArray <NSArray <DatePriceModel *>*>*)handle2WithRoomStatus:(NSArray <RoomDetailRoomStatusModel *>*)roomStatus;
- (NSArray <NSArray <DatePriceModel *>*>*)handle3WithRoomStatus:(NSArray <RoomDetailRoomStatusModel *>*)roomStatus;


+ (NSDate *)getToday;//系统本地时间
+ (NSDate *)dateHandle:(NSDate *)date;//date处理，小于6点当做前一天
+ (NSDate *)dateHandle2:(NSDate *)date;//date处理，返回当天00:00:00
+ (NSInteger)dayNightFromStart:(NSDate *)checkin End:(NSDate *)checkOut;//入住天数
+ (NSArray<NSDate *> *)getDatesBetween:(NSDate *)start And:(NSDate *)end;//如2～4为1天，3号
+ (NSArray<NSDate *> *)getDatesBetween2:(NSDate *)start And:(NSDate *)end;//如2～4为3天，2、3、4号
+ (BOOL)haveDateWithCheckinDate:(NSDate *)checkinDate checkoutDate:(NSDate *)checkoutDate inUnbookDates:(NSArray <NSArray <DatePriceModel *>*>*)unbooks;//入住和退房是否跨过不可选日期
+ (NSDate *)lateDate:(NSDate *)date Dates:(NSArray <NSArray <DatePriceModel *>*>*)unbooks;//在date之后，且在unbooks中离date最近的一天

@end
