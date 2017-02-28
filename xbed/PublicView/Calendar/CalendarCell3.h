//
//  CalendarCell3.h
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePriceModel.h"

typedef NS_ENUM(NSInteger, CalendarCellState3)
{
    CalendarCellNull3 = 0,
    CalendarCellOver3,//小于今天
    CalendarCellNormal3,
    CalendarCellUnbook3, //不可预订
    CalendarCellCheckin3,
    CalendarCellCheckout3,
    CalendarCellBetween3
};


@interface CalendarCell3 : UICollectionViewCell
{
@private
    UILabel *_lbTitle;
    UILabel *_lbPrice;
}

@property (nonatomic, strong)NSDate *date;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, assign)CalendarCellState3 state;

@end
