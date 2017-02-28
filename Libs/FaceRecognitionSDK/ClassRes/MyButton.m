//
//  MyButton.m
//  zuyaya
//
//  Created by 0 on 13-9-3.
//  Copyright (c) 2013年 0. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton
@synthesize url = _url;
- (void)dealloc
{
    self.url = nil;
    }
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
