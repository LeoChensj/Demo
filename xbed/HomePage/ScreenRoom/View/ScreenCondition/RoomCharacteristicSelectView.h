//
//  RoomCharacteristicSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  特色选择

#import <UIKit/UIKit.h>
#import "RoomCharacteristicCell.h"

@interface RoomCharacteristicSelectView : UIView
{
@private
    UILabel *_lbTitle;
    NSMutableArray <RoomCharacteristicCell *>*_cells;
}

@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*RoomCharacteristics;//所有特色标签
@property (nonatomic, strong)NSArray <NSString *>*selectRoomCharacteristics;//已经选择特色code


- (void)reset;


@end
