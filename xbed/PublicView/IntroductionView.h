//
//  IntroductionView.h
//  SelectDateDemo
//
//  Created by Leo.Chen on 15/12/24.
//  Copyright © 2015年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionView : UIView <UIScrollViewDelegate>
{
@private
    UIScrollView *_scrollView;
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    UIImageView *_imageView3;
    UIPageControl *_pageControl;
    
    BOOL _endFlag;
}

@end
