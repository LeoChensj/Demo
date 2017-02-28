//
//  NormalTableCell.h
//  xbed
//
//  Created by Leo.Chen on 16/7/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  tableViewCell  包含title、value（右对齐）、箭头、分割线（可选）

#import "TouchView.h"

@interface NormalTableCell : TouchView
{
@public
    UILabel *_lbTitle;
    UILabel *_lbValue;
    UIImageView *_imgvArrow;
    UIView *_vLine;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)UIColor *titleColor;
@property (nonatomic, strong)NSString *value;
@property (nonatomic, strong)UIColor *valueColor;
@property (nonatomic, assign)BOOL haveLine;
@property (nonatomic, assign)BOOL haveArrow;


@end
