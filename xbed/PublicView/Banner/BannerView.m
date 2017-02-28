//
//  BannerView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "BannerView.h"
#import "WebViewController.h"

@implementation BannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _index = 0;
        
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.clipsToBounds = YES;
        _backImageView.image = PlaceholderImage;
        [self addSubview:_backImageView];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(frame.size.width*3, frame.size.height);
        [self addSubview:_scrollView];
        
        self.interval = 5;
        
        
        
        
        _imgv1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imgv1.contentMode = UIViewContentModeScaleAspectFill;
        _imgv1.clipsToBounds = YES;
        [_scrollView addSubview:_imgv1];
        
        _imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
        _imgv2.userInteractionEnabled = YES;
        _imgv2.contentMode = UIViewContentModeScaleAspectFill;
        _imgv2.clipsToBounds = YES;
        [_scrollView addSubview:_imgv2];
        _currentImageView = _imgv2;
        
        _imgv3 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*2, 0, frame.size.width, frame.size.height)];
        _imgv3.contentMode = UIViewContentModeScaleAspectFill;
        _imgv3.clipsToBounds = YES;
        [_scrollView addSubview:_imgv3];
        
        
        UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageFunc)];
        [_imgv2 addGestureRecognizer:tapImage];
    }
    
    return self;
}

- (void)setDataArray:(NSArray<BannerModel *> *)dataArray
{
    _dataArray = dataArray;
    
    self.pageCount = dataArray.count;
    
    self.index = _index;
}

- (void)setDataArray2:(NSArray<NSString *> *)dataArray2
{
    _dataArray2 = dataArray2;
    
    self.pageCount = dataArray2.count;
    
    self.index = _index;
}

- (void)setIndex:(NSInteger)index
{
    if(_pageCount>0)
    {
        _index = index%_pageCount;
        
        _scrollView.contentOffset = CGPointMake(self.size.width, 0);
        
        //NSLog(@"index=%ld", _index);
        
        if(_dataArray && _dataArray.count)
        {
            [_imgv1 sd_setImageWithURL:[NSURL URLWithString:_dataArray[(index+_pageCount-1)%_pageCount].imageUrl] placeholderImage:_placeholderImage];
            [_imgv2 sd_setImageWithURL:[NSURL URLWithString:_dataArray[(index)%_pageCount].imageUrl] placeholderImage:_placeholderImage];
            [_imgv3 sd_setImageWithURL:[NSURL URLWithString:_dataArray[(index+1)%_pageCount].imageUrl] placeholderImage:_placeholderImage];
        }
        else if(_dataArray2 && _dataArray2.count)
        {
            [_imgv1 sd_setImageWithURL:[NSURL URLWithString:_dataArray2[(index+_pageCount-1)%_pageCount]] placeholderImage:_placeholderImage];
            [_imgv2 sd_setImageWithURL:[NSURL URLWithString:_dataArray2[(index)%_pageCount]] placeholderImage:_placeholderImage];
            [_imgv3 sd_setImageWithURL:[NSURL URLWithString:_dataArray2[(index+1)%_pageCount]] placeholderImage:_placeholderImage];
        }
        else
        {
            //NSLog(@"先设置dataArray");
        }
    }
}



#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x<self.frame.size.width)
    {
        self.index = (_index+_pageCount-1)%_pageCount;
    }
    else
    {
        self.index = (_index+1)%_pageCount;
    }
    
    [self startTimer];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    if(_pageCount>0)
    {
        self.index = (_index+1)%_pageCount;
        
        [self startTimer];
    }
}


- (void)timerFunc:(NSTimer *)timer
{
    [_scrollView setContentOffset:CGPointMake(self.size.width*2, 0) animated:YES];
}



- (void)startTimer
{
    if(!_timer.valid)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(timerFunc:) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}
- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}
- (void)addBannerViewTouchImageBlock:(BannerViewTouchImageBlock)block
{
    _block = block;
}


- (void)tapImageFunc
{
    if(_navigation && _dataArray[_index].url.length)
    {
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.url = _dataArray[_index].url;
        [_navigation pushViewController:webVC animated:YES];
    }
    
    if(_block)
    {
        _block(_dataArray[_index], _index);
    }
}



@end
