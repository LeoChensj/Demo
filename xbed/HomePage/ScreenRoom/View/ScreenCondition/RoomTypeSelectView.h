//
//  RoomTypeSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  户型选择

#import <UIKit/UIKit.h>
#import "RoomTypeCell.h"

@interface RoomTypeSelectView : UIView
{
@private
    UILabel *_lbTitle;
    NSMutableArray <RoomTypeCell *>*_cells;
}

@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*roomTypes;//所有户型标签
@property (nonatomic, strong)NSArray <NSString *>*selectRoomTypes;//已经选择户型code


- (void)reset;

@end
