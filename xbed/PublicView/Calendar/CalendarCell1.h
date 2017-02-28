//
//  CalendarCell.h
//  xbed
//
//  Created by Leo.Chen on 16/7/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  不带价格  可选

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CalendarCellState)
{
    CalendarCellNull = 0,
    CalendarCellOver,//小于今天
    CalendarCellNormal,
    CalendarCellCheckin,
    CalendarCellCheckout,
    CalendarCellBetween
};

@interface CalendarCell1 : UICollectionViewCell
{
@private
    UILabel *_lbTitle;
}

@property (nonatomic, strong)NSDate *date;
@property (nonatomic, assign)CalendarCellState state;

@end
