//
//  OrderListBackScrollView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderListBackScrollView.h"

@implementation OrderListBackScrollView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH*5, MAIN_SCREEN_HEIGHT-64-45);
        self.delegate = self;
    }
    
    return self;
}

- (void)addOrderListBackScrollViewBlock:(OrderListBackScrollViewBlock)block
{
    _block = block;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    
    [self setContentOffset:CGPointMake(MAIN_SCREEN_WIDTH*index, 0) animated:NO];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/MAIN_SCREEN_WIDTH;
    
    if(_block)
    {
        _block(index);
    }
}

@end
