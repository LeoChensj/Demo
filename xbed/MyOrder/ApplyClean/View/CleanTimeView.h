//
//  CleanTimeView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CleanTimeSelectCell.h"
#import "CheckinCleanRespModel.h"

@interface CleanTimeView : UIView

@property (nonatomic, strong, readonly)NSMutableArray <CleanTimeSelectCell *>*cells;
@property (nonatomic, strong)CheckinCleanTimeItemModel *selectModel;
@property (nonatomic, strong)NSArray <CheckinCleanTimeItemModel *>*dataArray;

@end
