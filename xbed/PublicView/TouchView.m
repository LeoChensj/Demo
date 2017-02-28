//
//  TouchView.m
//  hbec
//
//  Created by Leo on 15/10/10.
//  Copyright © 2015年 Leo.Chen. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

- (id)init
{
    if(self = [self initWithFrame:CGRectZero])
    {
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.normalColor = [UIColor clearColor];
        self.touchColor = [UIColor clearColor];
        
        [self addTarget:self action:@selector(resumeColor) forControlEvents:UIControlEventTouchCancel];
    }
    
    return self;
}


- (void)setNormalColor:(UIColor *)normalColor
{
    self.backgroundColor = normalColor;
    _normalColor = normalColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    self.backgroundColor = self.touchColor;

    //NSLog(@"touchBegin!");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self performSelector:@selector(resumeColor) withObject:nil afterDelay:0.15f];
    //NSLog(@"touchEnd!");
}

- (void)resumeColor
{
    self.backgroundColor = self.normalColor;
    //NSLog(@"resumeColor");
}

@end
