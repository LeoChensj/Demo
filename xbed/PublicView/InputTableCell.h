//
//  InputTableCell.h
//  xbed
//
//  Created by Leo.Chen on 16/7/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  有输入框  包含title、tfValue

#import "TouchView.h"
#import "LeoTextField.h"

@interface InputTableCell : UIView
{
@private
    UILabel *_lbTitle;
    UIView *_vLine;
}

@property (nonatomic, strong, readonly)LeoTextField *tfValue;

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *value;
@property (nonatomic, strong)NSString *placeholder;
@property (nonatomic, assign)UIKeyboardType keyboardType;
@property (nonatomic, assign)BOOL haveLine;


@end
