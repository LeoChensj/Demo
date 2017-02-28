//
//  CleanTimeSelectCell.m
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CleanTimeSelectCell.h"

@implementation CleanTimeSelectCell

- (instancetype)init
{
    if(self = [super init])
    {
        self.titleLabel.font = Font(13);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 17;
        
        WS(ws);
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if(ws.states==1)
            {
                ws.states = 2;
                
                if(ws.block)
                {
                    ws.block(ws.states);
                }
            }
            
        }];
    }
    
    return self;
}

- (void)addCleanTimeSelectCellBlock:(CleanTimeSelectCellBlock)block
{
    _block = block;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setStates:(NSInteger)states
{
    _states = states;
    
    if(states==0)
    {
        self.enabled = NO;
        
        self.backgroundColor = Background_Color;
        [self setTitleColor:Secondary_Text_Color2 forState:UIControlStateNormal];
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0;
    }
    else if(states==1)
    {
        self.enabled = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:Main_Text_Color forState:UIControlStateNormal];
        self.layer.borderColor = Main_Text_Color.CGColor;
        self.layer.borderWidth = LINE_WIDTH;
    }
    else if(states==2)
    {
        self.enabled = YES;
        
        self.backgroundColor = Blue_Color;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0;
    }
}

@end
