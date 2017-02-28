//
//  InputTableCell.m
//  xbed
//
//  Created by Leo.Chen on 16/7/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InputTableCell.h"

@implementation InputTableCell

@synthesize value = _value;

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(13);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _tfValue = [[LeoTextField alloc] init];
        _tfValue.textColor = Main_Text_Color;
        _tfValue.font = Font(13);
        _tfValue.borderStyle = UITextBorderStyleNone;
        _tfValue.returnKeyType = UIReturnKeyDone;
        _tfValue.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_tfValue];
        [_tfValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-100-10);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = Seg_Line_Color;
        [self addSubview:_vLine];
        [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}
- (void)setValue:(NSString *)value
{
    _value = value;
    
    _tfValue.text = value;
}
- (NSString *)value
{
    _value = _tfValue.text;
    
    return _value;
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    _tfValue.placeholder = placeholder;
}
- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    
    _tfValue.keyboardType = keyboardType;
}
- (void)setHaveLine:(BOOL)haveLine
{
    _haveLine = haveLine;
    
    _vLine.hidden = !haveLine;
}

@end
