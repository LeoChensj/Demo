//
//  SimpleTableCell.h
//  xbed
//
//  Created by Leo.Chen on 16/7/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  tableViewCell  包含title（居中）、分割线（上下、可选）

#import "TouchView.h"

@interface SimpleTableCell : TouchView
{
@private
    UILabel *_lbTitle;
    UIView *_vLine1;
    UIView *_vLine2;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)BOOL haveLine1;
@property (nonatomic, assign)BOOL haveLine2;

@end
