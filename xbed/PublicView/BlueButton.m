//
//  BlueButton.m
//  xbed
//
//  Created by Leo.Chen on 16/8/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "BlueButton.h"

@implementation BlueButton

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = Blue_Color;
        self.touchColor = Blue_Click_Color;
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.titleLabel.font = Font(16);
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
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
