//
//  PositionCell1.h
//  xbed
//
//  Created by Leo.Chen on 16/7/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenRoomRespModel.h"

@interface PositionCell1 : UITableViewCell

@property (nonatomic, strong, readonly)UILabel *lbTitle;

@property (nonatomic, strong)ScreenRoomTagModel *model;
@property (nonatomic, assign)NSInteger state;//0:普通   1:选中

@end
