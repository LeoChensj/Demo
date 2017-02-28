//
//  ScreenConditionBar.h
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  筛选条件栏

#import "TouchView.h"
#import "ScreenRoomViewModel.h"

//item
@interface ScreenConditionItem : TouchView
{
@private
    UILabel *_lbTitle;
    UIImageView *_imgvDown;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)UIFont *font;
@property (nonatomic, assign)NSInteger states;//0表示普通状态，字为黑色；1表示选中了条件，字为蓝色

@end



//bar 4个item 日期 位置 筛选 排序
@interface ScreenConditionBar : UIView
{
@private
    UIView *_line1;
    UIView *_line2;
    UIView *_line3;
}

@property (nonatomic, strong)ScreenConditionItem *item1;
@property (nonatomic, strong)ScreenConditionItem *item2;
@property (nonatomic, strong)ScreenConditionItem *item3;
@property (nonatomic, strong)ScreenConditionItem *item4;


@property (nonatomic, strong)ScreenRoomViewModel *viewModel;

@end
