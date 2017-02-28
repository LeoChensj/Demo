//
//  CleanTimeSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CleanTimeSelectCell.h"
#import "CleanTimeView.h"
#import "CheckinCleanRespModel.h"

@interface CleanTimeSelectView : UIScrollView

@property (nonatomic, strong, readonly)CleanTimeSelectCell *cellToday;
@property (nonatomic, strong, readonly)CleanTimeSelectCell *cellTomorrow;
@property (nonatomic, strong, readonly)CleanTimeView *timeView;

@property (nonatomic, strong)NSArray <CheckinCleanTimeItemModel *>*todayDataArray;
@property (nonatomic, strong)NSArray <CheckinCleanTimeItemModel *>*tomorrowDataArray;
@property (nonatomic, strong)CheckinCleanTimeItemModel *selectTime;

@end
