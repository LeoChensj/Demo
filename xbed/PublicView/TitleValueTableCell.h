//
//  TitleValueTableCell.h
//  xbed
//
//  Created by Leo.Chen on 16/7/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  类似InputTableCell，但不能输入，包含title、value

#import "TouchView.h"

@interface TitleValueTableCell : TouchView
{
@private
    UILabel *_lbTitle;
    UILabel *_lbValue;
    UIView *_vLine;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *value;
@property (nonatomic, assign)BOOL haveLine;

@end
