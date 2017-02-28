//
//  CouponActivitySegmentedControl.m
//  xbed
//
//  Created by Leo.Chen on 16/8/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CouponActivitySegmentedControl.h"

@implementation CouponActivitySegmentedControl

- (instancetype)init
{
    if(self = [super initWithItems:@[@"优惠券", @"活动"]])
    {
        self.tintColor = Blue_Color;
        self.selectedSegmentIndex = 0;
    }
    
    return self;
}

@end
