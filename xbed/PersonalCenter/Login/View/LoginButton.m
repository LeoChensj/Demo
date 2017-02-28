//
//  LoginButton.m
//  xbed
//
//  Created by Leo.Chen on 16/7/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LoginButton.h"

@implementation LoginButton

- (instancetype)init
{
    if(self = [super init])
    {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        
        [self setTitle:@"登录" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = Font(16);
        
        
    }
    
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if(enabled)
    {
        self.backgroundColor = Blue_Color;
    }
    else
    {
        self.backgroundColor = Blue_Unable_Color;
    }
}

@end
