//
//  RoomTypeCell.h
//  xbed
//
//  Created by Leo.Chen on 16/7/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  户型选择cell

#import <UIKit/UIKit.h>
#import "ScreenRoomRespModel.h"

@interface RoomTypeCell : UIButton

@property (nonatomic, strong)ScreenRoomTagModel *model;
@property (nonatomic, assign)NSInteger states;//0:普通  1:选中

@end
