//
//  VerifyCodeButton.m
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "VerifyCodeButton.h"

@implementation VerifyCodeButton

- (instancetype)init
{
    if(self = [super init])
    {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        
        self.titleLabel.font = Font(12);
        
        self.states = 0;
    }
    
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if(enabled)
    {
        if(self.states)
        {
            self.enabled = NO;
        }
        else
        {
            self.backgroundColor = Blue_Color;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    else
    {
        self.backgroundColor = Background_Color;
        [self setTitleColor:Secondary_Text_Color2 forState:UIControlStateNormal];
    }
}

- (void)setStates:(BOOL)states
{
    _states = states;
    
    if(states==NO)
    {
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else
    {
        self.enabled = NO;
        
        __block NSInteger sec = 60;
        
        [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0] take:61] subscribeNext:^(id x) {
            
            if(sec>0)
            {
                //NSLog(@"sec=%ld", sec);
                NSString *title = [NSString stringWithFormat:@"%lds后重新获取", sec];
                [self setTitle:title forState:UIControlStateNormal];
                sec--;
            }
            else
            {
                self.states = NO;
                self.enabled = YES;
            }
            
        }];
        
        
    }
}



@end
