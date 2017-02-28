//
//  BlueEnableButton.m
//  xbed
//
//  Created by Leo.Chen on 16/8/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "BlueEnableButton.h"

@implementation BlueEnableButton

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = Blue_Color;
        self.unableColor = Blue_Unable_Color;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
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

@end
