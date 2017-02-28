//
//  ScreenCitySelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/9.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenCityCell.h"
#import "ScreenRoomViewModel.h"

typedef void (^ScreenCitySelectViewSelectBlock)(NSString *city);
typedef void (^ScreenCitySelectViewCloseBlock)();

@interface ScreenCitySelectView : UIView
{
@private
    UIView *_vCancel;
    UIView *_vBlack;
    UIScrollView *_vContent;
    NSMutableArray <ScreenCityCell *>*_cells;
}

@property (nonatomic, strong)ScreenRoomViewModel *viewModel;
@property (nonatomic, strong)NSString *city;//选择的城市
@property (nonatomic, strong)ScreenCitySelectViewSelectBlock blockSelect;
@property (nonatomic, strong)ScreenCitySelectViewCloseBlock blockClose;


- (void)addScreenCitySelectViewSelectBlock:(ScreenCitySelectViewSelectBlock)blockSelect closeBlock:(ScreenCitySelectViewCloseBlock)blockClose;

@end
