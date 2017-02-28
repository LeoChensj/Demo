//
//  LoginPasswordView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LoginPasswordView.h"

@implementation LoginPasswordView

- (instancetype)init
{
    if(self = [super init])
    {
        _lbTitle.text = @"验证码";
        
        self.textField.limitLength = 6;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.secureTextEntry = YES;
        
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30-10-70*XSCALE);
            
        }];
    }
    
    return self;
}

@end
