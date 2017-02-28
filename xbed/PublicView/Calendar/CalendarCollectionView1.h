//
//  CalendarCollectionView1.h
//  xbed
//
//  Created by Leo.Chen on 16/7/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  不带价格  可选

#import <UIKit/UIKit.h>
#import "CalendarCell1.h"

@class CalendarCollectionView1;
typedef void (^CalendarCollectionView1SelectCompleteBlock)(CalendarCollectionView1 *view, NSDate *checkinDate, NSDate *checkoutDate);

@interface CalendarCollectionView1 : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSArray <NSArray <NSDate *>*>*dataArray;

@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;

@property (nonatomic, strong)CalendarCollectionView1SelectCompleteBlock block;


@end
