//
//  CalendarCollectionView3.h
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  带价格 可选

#import <UIKit/UIKit.h>
#import "CalendarCell3.h"
#import "RoomStatusRespModel.h"

@class CalendarCollectionView3;
typedef void (^CalendarCollectionView3SelectCompleteBlock)(CalendarCollectionView3 *view, NSDate *checkinDate, NSDate *checkoutDate);


@interface CalendarCollectionView3 : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSArray <NSArray <DatePriceModel *>*>*dataArray;
@property (nonatomic, strong)NSArray <RoomDetailRoomStatusModel *>*roomStatus;

@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;
@property (nonatomic, assign)BOOL isOverstay;//是否续住
@property (nonatomic, assign)NSInteger rentType;

@property (nonatomic, strong)NSDate *unbookCheckout;//不可订日期可作为退房日期

@property (nonatomic, strong)CalendarCollectionView3SelectCompleteBlock block;

@end
