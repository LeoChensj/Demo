//
//  LoginPhoneView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LoginPhoneView.h"

@implementation LoginPhoneView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"手机";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
    
        }];
        
        
        _textField = [[LeoTextField alloc] init];
        _textField.limitLength = 11;
        _textField.textColor = Main_Text_Color;
        _textField.font = Font(14);
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30-95-10-70*XSCALE);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(70*XSCALE);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
        
        
    }
    
    return self;
}

@end
