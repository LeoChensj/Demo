//
//  CalendarCell2.h
//  xbed
//
//  Created by Leo.Chen on 16/8/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  详情页的日历

#import <UIKit/UIKit.h>
#import "DatePriceModel.h"

typedef NS_ENUM(NSInteger, CalendarCellState2)
{
    CalendarCellNull2 = 0,
    CalendarCellOver2,//小于今天
    CalendarCellNormal2,
    CalendarCellUnbook2 //不可预订
};

@interface CalendarCell2 : UICollectionViewCell
{
@private
    UILabel *_lbTitle;
    UILabel *_lbPrice;
}

@property (nonatomic, strong)NSDate *date;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, assign)CalendarCellState2 state;

@end
