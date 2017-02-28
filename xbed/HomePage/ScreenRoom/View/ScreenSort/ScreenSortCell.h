//
//  ScreenSortCell.h
//  xbed
//
//  Created by Leo.Chen on 16/7/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenRoomRespModel.h"

@interface ScreenSortCell : UIButton

@property (nonatomic, strong)ScreenRoomTagModel *model;
@property (nonatomic, assign)NSInteger states;//0:普通  1:选中

@end
