//
//  HomeMainBanner.m
//  xbed
//
//  Created by Leo.Chen on 16/7/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomeMainBanner.h"

@implementation HomeMainBanner

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 284*MAIN_SCREEN_WIDTH/375)])
    {
        self.backgroundColor = Background_Color;
        self.interval = 4;
        self.navigation = [RootViewController getInstance];
        self.placeholderImage = PlaceholderImage;
        
        _pageControl = [[SMPageControl alloc] init];
        _pageControl.pageIndicatorImage = nil;
        _pageControl.currentPageIndicatorImage = nil;
        [self addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
            
        }];
        
        RAC(_pageControl, numberOfPages) = RACObserve(self, pageCount);
        RAC(_pageControl, currentPage) = RACObserve(self, index);
        
    }
    
    return self;
}

@end
