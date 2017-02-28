//
//  NetworkOpenDoorCardIdView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "NetworkOpenDoorCardIdView.h"

@implementation NetworkOpenDoorCardIdView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"身份证后6位";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(84);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _textField = [[LeoTextField alloc] init];
        _textField.limitLength = 6;
        _textField.textColor = Main_Text_Color;
        _textField.font = Font(14);
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.returnKeyType = UIReturnKeyDone;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-84-10-10-95-10);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(_lbTitle.mas_right).offset(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
            
        }];
        
        
        
    }
    
    return self;
}

@end
