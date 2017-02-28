//
//  CalendarCollectionView2.h
//  xbed
//
//  Created by Leo.Chen on 16/8/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  详情页的日历

#import <UIKit/UIKit.h>
#import "CalendarCell2.h"

@interface CalendarCollectionView2 : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong, readonly)UICollectionViewFlowLayout *layout;

@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSArray <DatePriceModel *>*dataArray;

@end
