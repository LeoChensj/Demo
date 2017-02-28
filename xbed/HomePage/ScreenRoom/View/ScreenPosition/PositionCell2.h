//
//  PositionCell2.h
//  xbed
//
//  Created by Leo.Chen on 16/7/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenRoomRespModel.h"

@interface PositionCell2 : UITableViewCell
{
@private
    UILabel *_lbTitle;
    UIView *_line;
}

@property (nonatomic, strong)ScreenRoomTagModel *model;
@property (nonatomic, assign)NSInteger state;//0:普通   1:选中

@end
