//
//  ScreenSortView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenSortCell.h"
#import "ScreenRoomViewModel.h"

@interface ScreenSortView : UIView
{
@private
    UIView *_vCancel;
    UIView *_vBlack;
    UIView *_vContent;
    NSMutableArray <ScreenSortCell *>*_cells;
}

@property (nonatomic, strong)ScreenRoomViewModel *viewModel;
@property (nonatomic, strong)ScreenRoomTagModel *selectSort;//选择的排序方式

@end
