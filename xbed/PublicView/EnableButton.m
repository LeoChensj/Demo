//
//  EnableButton.m
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "EnableButton.h"

@implementation EnableButton

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if(enabled)
    {
        self.backgroundColor = _normalColor;
    }
    else
    {
        self.backgroundColor = _unableColor;
    }
}

@end
