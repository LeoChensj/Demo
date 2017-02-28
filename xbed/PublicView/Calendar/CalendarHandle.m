//
//  CalendarHandle.m
//  xbed
//
//  Created by Leo.Chen on 16/7/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalendarHandle.h"

@implementation CalendarHandle

- (instancetype)initWithToday:(NSDate *)today
{
    if(self = [super init])
    {
        _today = today;
        
        _firstMonthDay = [[_today dateMonthStart] dateByAddingHour:8];
        _secondMonthDay = [[[_today dateByAddingMonth:1] dateMonthStart] dateByAddingHour:8];
        _thirdMonthDay = [[[_today dateByAddingMonth:2] dateMonthStart] dateByAddingHour:8];
    }
    
    return self;
}

- (NSArray<NSArray<NSDate *> *> *)handle1
{
    NSArray<NSArray<NSDate *> *> *array = nil;
    
    NSMutableArray<NSDate *> *firstMonthArr = [NSMutableArray arrayWithCapacity:[self numberOfDaysInMonth:_firstMonthDay]];
    NSMutableArray<NSDate *> *secondMonthArr = [NSMutableArray arrayWithCapacity:[self numberOfDaysInMonth:_secondMonthDay]];
    NSMutableArray<NSDate *> *thirdMonthArr = [NSMutableArray arrayWithCapacity:[self numberOfDaysInMonth:_thirdMonthDay]];
    
    for (NSInteger i=0; i<[self numberOfDaysInMonth:_firstMonthDay]; i++)
    {
        NSDate *date = [_firstMonthDay dateByAddingDays:i];
        
        [firstMonthArr addObject:date];
    }
    
    for (NSInteger i=0; i<[self numberOfDaysInMonth:_secondMonthDay]; i++)
    {
        NSDate *date = [_secondMonthDay dateByAddingDays:i];
        
        [secondMonthArr addObject:date];
    }
    
    for (NSInteger i=0; i<[self numberOfDaysInMonth:_thirdMonthDay]; i++)
    {
        NSDate *date = [_thirdMonthDay dateByAddingDays:i];
        
        [thirdMonthArr addObject:date];
    }
    
    array = @[firstMonthArr, secondMonthArr, thirdMonthArr];
    
    return array;
}
- (NSArray<NSArray<DatePriceModel *> *> *)handle2WithRoomStatus:(NSArray<RoomDetailRoomStatusModel *> *)roomStatus
{
    NSArray<NSArray<DatePriceModel *> *> *array = nil;
    
    NSMutableArray<DatePriceModel *> *firstMonthArr = [NSMutableArray arrayWithCapacity:[self numberOfDaysInMonth:_firstMonthDay]];
    NSMutableArray<DatePriceModel *> *secondMonthArr = [NSMutableArray arrayWithCapacity:[self numberOfDaysInMonth:_secondMonthDay]];
    NSMutableArray<DatePriceModel *> *thirdMonthArr = [NSMutableArray arrayWithCapacity:[self numberOfDaysInMonth:_thirdMonthDay]];
    
    for (NSInteger i=0; i<[self numberOfDaysInMonth:_firstMonthDay]; i++)//第一个月
    {
        NSDate *date = [_firstMonthDay dateByAddingDays:i];
        
        DatePriceModel *model = [[DatePriceModel alloc] init];
        model.date = date;
        
        if([date isGreaterOrEqualToDate:_today])
        {
            NSInteger index = i-_today.day+1;
            
            if(roomStatus.count>index)
            {
                model.price = roomStatus[index].price;
                
                if(roomStatus[index].state.integerValue==1)//可订
                {
                    model.state = 1;
                }
                else//不可订
                {
                    model.state = 0;
                }
            }
            else
            {
                model.price = @-999;
                model.state = 1;
            }
            
        }
        
        [firstMonthArr addObject:model];
    }
    
    for (NSInteger i=0; i<[self numberOfDaysInMonth:_secondMonthDay]; i++)//第二个月
    {
        NSDate *date = [_secondMonthDay dateByAddingDays:i];
        
        NSInteger index = firstMonthArr.count+i-_today.day+1;
        
        DatePriceModel *model = [[DatePriceModel alloc] init];
        model.date = date;
        
        if(roomStatus.count>index)
        {
            model.price = roomStatus[index].price;
            if(roomStatus[index].state.integerValue==1)//可订
            {
                model.state = 1;
            }
            else//不可订
            {
                model.state = 0;
            }
        }
        else
        {
            model.price = @-999;
            model.state = 1;
        }
        
        
        
        [secondMonthArr addObject:model];
    }
    
    for (NSInteger i=0; i<[self numberOfDaysInMonth:_thirdMonthDay]; i++)//第三个月
    {
        NSDate *date = [_thirdMonthDay dateByAddingDays:i];
        
        NSInteger index = firstMonthArr.count+secondMonthArr.count+i-_today.day+1;
        
        DatePriceModel *model = [[DatePriceModel alloc] init];
        model.date = date;
        
        
        if(roomStatus.count>index)
        {
            model.price = roomStatus[index].price;
            
            if(roomStatus[index].state.integerValue==1)//可订
            {
                model.state = 1;
            }
            else//不可订
            {
                model.state = 0;
            }
        }
        else//拿不到数据，默认情况
        {
            model.price = @-999;
            model.state = 1;
        }
        
        [thirdMonthArr addObject:model];
    }
    
    array = @[firstMonthArr, secondMonthArr, thirdMonthArr];
    
    return array;
}
- (NSArray<NSArray<DatePriceModel *> *> *)handle3WithRoomStatus:(NSArray<RoomDetailRoomStatusModel *> *)roomStatus
{
    return [self handle2WithRoomStatus:roomStatus];
}






+ (NSDate *)getToday
{
    NSDate *today = nil;
    
    NSDate *currentDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: currentDate];
    currentDate = [currentDate  dateByAddingTimeInterval: interval];
    
    NSDate *sixDate = currentDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:sixDate];
    components.hour = 6;
    components.minute = 0;
    components.second = 0;
    sixDate = [calendar dateFromComponents:components];
    
    //NSLog(@"currentDate=%@\nsixDate=%@", currentDate, sixDate);
    
    if(![currentDate isEqual:sixDate] &&
       [[currentDate earlierDate:sixDate] isEqual:currentDate])//6点之前，从前一天开始选
    {
        NSDate *yestoday = [[NSDate alloc] init];
        NSTimeInterval intervalTomorrow = [currentDate timeIntervalSince1970]-24*3600;
        yestoday = [NSDate dateWithTimeIntervalSince1970:intervalTomorrow];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:yestoday];
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        today = [calendar dateFromComponents:components];
    }
    else//6点或6点之后，从今天开始
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:sixDate];
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        today = [calendar dateFromComponents:components];
        //NSLog(@"today2=%@", today);
    }
    
    return today;
}

+ (NSDate *)dateHandle:(NSDate *)date
{
    NSDate *dateHandle = nil;
    
    NSDate *sixDate = date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:sixDate];
    components.hour = 6;
    components.minute = 0;
    components.second = 0;
    sixDate = [calendar dateFromComponents:components];
    
    if([date isLessDate:sixDate])//6点之前，从前一天开始选
    {
        NSDate *yestoday = [[NSDate alloc] init];
        NSTimeInterval intervalTomorrow = [date timeIntervalSince1970]-24*3600;
        yestoday = [NSDate dateWithTimeIntervalSince1970:intervalTomorrow];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:yestoday];
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        dateHandle = [calendar dateFromComponents:components];
    }
    else//6点或6点之后，从今天开始
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:sixDate];
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        dateHandle = [calendar dateFromComponents:components];
    }
    
    return dateHandle;
}

+ (NSDate *)dateHandle2:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    date = [calendar dateFromComponents:components];
    
    return date;
}


+ (NSInteger)dayNightFromStart:(NSDate *)checkin End:(NSDate *)checkOut
{
    NSInteger dayNight;
    
    NSTimeInterval intervalCheckin = checkin.timeIntervalSince1970;
    NSTimeInterval intervalChechout = checkOut.timeIntervalSince1970;
    
    dayNight = (NSInteger)((intervalChechout-intervalCheckin)/(24*60*60));
    
    return dayNight;
}

+ (NSArray<NSDate *> *)getDatesBetween:(NSDate *)start And:(NSDate *)end
{
    NSMutableArray<NSDate *> *dates = [NSMutableArray array];
    
    for(NSInteger i=1;i<=([self dayNightFromStart:start End:end]-1);i++)
    {
        [dates addObject:[start dateByAddingDays:i]];
    }
    
    return (NSArray<NSDate *> *)dates;
}

+ (NSArray<NSDate *> *)getDatesBetween2:(NSDate *)start And:(NSDate *)end
{
    NSMutableArray<NSDate *> *dates = [NSMutableArray array];
    
    NSInteger count = [self dayNightFromStart:start End:end]+1;
    
    for(NSInteger i=0;i<count;i++)
    {
        [dates addObject:[start dateByAddingDays:i]];
    }
    
    return (NSArray<NSDate *> *)dates;
}

+ (BOOL)haveDateWithCheckinDate:(NSDate *)checkinDate checkoutDate:(NSDate *)checkoutDate inUnbookDates:(NSArray <NSArray <DatePriceModel *>*>*)unbooks
{
    for(NSDate *date in [self getDatesBetween:checkinDate And:checkoutDate])
    {
        for(NSInteger i=0;i<unbooks.count;i++)
        {
            for(NSInteger j=0;j<unbooks[i].count;j++)
            {
                if([date isEqualToDay:unbooks[i][j].date])
                {
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

+ (NSDate *)lateDate:(NSDate *)date Dates:(NSArray <NSArray <DatePriceModel *>*>*)unbooks
{
    for(NSInteger i=0;i<unbooks.count;i++)
    {
        for(NSInteger j=0;j<unbooks[i].count;j++)
        {
            if([date isLessDate:unbooks[i][j].date])
            {
                return unbooks[i][j].date;
            }
        }
    }
    
    return nil;
}










#pragma mark - Helper
//获取某个月有多少天
- (NSUInteger)numberOfDaysInMonth:(NSDate *)date
{
    //频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    
}

- (NSInteger)haveDate:(NSDate *)date inArray:(NSArray <DatePriceModel *>*)array
{
    for (NSInteger i=0;i<array.count;i++)
    {
        if([date isEqualToDay:array[i].date])
        {
            return i;
        }
    }
    
    return -1;
}



@end
