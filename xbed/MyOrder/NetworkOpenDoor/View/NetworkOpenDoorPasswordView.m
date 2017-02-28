//
//  NetworkOpenDoorPasswordView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "NetworkOpenDoorPasswordView.h"

@implementation NetworkOpenDoorPasswordView

- (instancetype)init
{
    if(self = [super init])
    {
        _lbTitle.text = @"验证码";
        
        self.textField.limitLength = 6;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        self.textField.secureTextEntry = YES;
        
        _line.hidden = YES;
        
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-84-10-10);
            
        }];
    }
    
    return self;
}

@end
