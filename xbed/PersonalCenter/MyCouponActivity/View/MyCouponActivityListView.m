//
//  MyCouponActivityListView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyCouponActivityListView.h"

@implementation MyCouponActivityListView

- (instancetype)init
{
    if(self = [super init])
    {
        self.allowSelect = NO;
        self.headTitle = @"以下优惠券已过期";
    }
    
    return self;
}


@end
