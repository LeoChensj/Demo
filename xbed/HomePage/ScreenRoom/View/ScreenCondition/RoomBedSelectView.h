//
//  RoomBedSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenRoomRespModel.h"

@interface RoomBedSelectView : UIView <UIScrollViewDelegate>
{
@private
    UILabel *_lbTitle;
    UIScrollView *_scrollViewNormal;
    UIScrollView *_scrollViewBlue;
}

@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*roomBeds;//所有床数标签
@property (nonatomic, strong)ScreenRoomTagModel *bedModel; //当前选择床位数  nil表示不限

- (void)reset;

@end
