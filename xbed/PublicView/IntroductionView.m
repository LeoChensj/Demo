//
//  IntroductionView.m
//  SelectDateDemo
//
//  Created by Leo.Chen on 15/12/24.
//  Copyright © 2015年 Leo.Chen. All rights reserved.
//

#import "IntroductionView.h"
#import "UIImage+GIF.h"

@implementation IntroductionView

- (id)init
{
    if(self=[super init])
    {
        self.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
        self.backgroundColor = [UIColor whiteColor];
        _endFlag = YES;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH*4, MAIN_SCREEN_HEIGHT);
        [self addSubview:_scrollView];
        
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
        _imageView1.image = [UIImage sd_animatedGIFNamed:@"Introduction1"];
        _imageView1.clipsToBounds = YES;
        _imageView1.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:_imageView1];
        
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
        _imageView2.image = [UIImage sd_animatedGIFNamed:@"Introduction2"];
        _imageView2.clipsToBounds = YES;
        _imageView2.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:_imageView2];
        
        _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WIDTH*2, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
        _imageView3.image = [UIImage sd_animatedGIFNamed:@"Introduction3"];
        _imageView3.clipsToBounds = YES;
        _imageView3.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:_imageView3];
        
        

        //pageControl
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 4;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithCSS:@"#ecf4ff"];
        _pageControl.currentPageIndicatorTintColor = Blue_Color;
        _pageControl.center = CGPointMake(MAIN_SCREEN_WIDTH/2, MAIN_SCREEN_HEIGHT-40);
        [self addSubview:_pageControl];
        
    }
    
    return self;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //CGFloat xf = scrollView.contentOffset.x/scrollView.contentSize.width;
    
    CGFloat xf3 = (scrollView.contentOffset.x-scrollView.frame.size.width*2)/MAIN_SCREEN_WIDTH;
    if(xf3>0)
    {
        self.alpha = 1-xf3;
    }
    if(xf3>=1)
    {
        if(_endFlag)//保证只调用一次
        {
            _endFlag = NO;

            self.alpha = 0;

            WS(ws);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [ws removeMe];
                
            });
            
        }
    }
}

- (void)removeMe
{
    [self removeFromSuperview];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x/MAIN_SCREEN_WIDTH;
    _pageControl.currentPage = currentPage;
}




@end
