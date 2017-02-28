//
//  VillageNavigationViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "VillageNavigationViewController.h"

@implementation VillageNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.imgLeft = @"ic_back";
    self.headView.title = @"小区导航图";
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64)];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.maximumZoomScale = 3;
    _scrollView.minimumZoomScale = 1;
    [self.view addSubview:_scrollView];
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds = YES;
    [_scrollView addSubview:_imageView];
    
    WS(ws);
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.imageNavigation] placeholderImage:PlaceholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(image)
        {
            CGFloat imgWidth = image.size.width;
            CGFloat imgHeight = image.size.height;
            CGFloat xScale = MAIN_SCREEN_WIDTH/imgWidth;
            CGFloat contentHeight = imgHeight*xScale;
            
            ws.imageView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, contentHeight);
            ws.scrollView.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH, contentHeight);
        }
        else
        {
            NSLog(@"下载小区导航图失败");
        }
        
    }];
    
}

#pragma mark - UIScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}



- (VillageNavigationViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[VillageNavigationViewModel alloc] init];
    }
    
    return _viewModel;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
