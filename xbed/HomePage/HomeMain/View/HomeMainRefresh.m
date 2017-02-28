//
//  HomeMainRefresh.m
//  xbed
//
//  Created by Leo.Chen on 16/7/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomeMainRefresh.h"


@implementation HomeMainRefresh

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if((self = [super initWithScrollView:scrollView target:self refreshAction:@selector(refreshFunc:) plist:@"XbedRefresh" color:Blue_Color lineWidth:2 dropHeight:120 scale:1 horizontalRandomness:50 reverseLoadingAnimation:YES internalAnimationFactor:0.5]))
    {
        scrollView.delegate = self;
        
        CGFloat x = self.frame.origin.x;
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        UILabel *lbTheme = [[UILabel alloc] init];
        lbTheme.text = @"温暖 · 连通 · 自由";
        lbTheme.font = [UIFont fontWithName:GlobalFontName size:15];
        lbTheme.textColor = Blue_Color;
        lbTheme.textAlignment = NSTextAlignmentCenter;
        [lbTheme sizeToFit];
        [self addSubview:lbTheme];
        lbTheme.center = CGPointMake(width/2, height+20);
        
        UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(-x, -10, 70, 73)];
        star.image = [UIImage imageNamed:@"pic_index_refresh_star"];
        [self addSubview:star];
        
        UIImageView *moon = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH-x-70, -20, 70, 73)];
        moon.image = [UIImage imageNamed:@"pic_index_refresh_moon"];
        [self addSubview:moon];
    }
    
    return self;
}

- (void)addHomeMainRefreshDataBlock:(HomeMainRefreshDataBlock)block
{
    _block = block;
}


- (void)refreshFunc:(HomeMainRefresh *)refresh
{
    if(self.block)
    {
        self.block(refresh);
    }
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self scrollViewDidScroll];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self scrollViewDidEndDragging];
}





@end
