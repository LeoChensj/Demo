//
//  BannerView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerModel.h"

typedef void (^BannerViewTouchImageBlock)(BannerModel *model, NSInteger index);

@interface BannerView : UIView <UIScrollViewDelegate>
{
@private
    UIImageView *_imgv1;
    UIImageView *_imgv2;
    UIImageView *_imgv3;
    
    NSTimer *_timer;
}

@property (nonatomic, strong)UIImage *placeholderImage;
@property (nonatomic, assign)NSTimeInterval interval;
@property (nonatomic, strong)UINavigationController *navigation;
@property (nonatomic, strong)NSArray <BannerModel *>*dataArray;
@property (nonatomic, strong)NSArray <NSString *>*dataArray2;
@property (nonatomic, assign)NSInteger pageCount;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)BannerViewTouchImageBlock block;

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)UIImageView *currentImageView;
@property (nonatomic, strong, readonly)UIImageView *backImageView;//用于预览的定位图片

- (void)startTimer;
- (void)stopTimer;
- (void)addBannerViewTouchImageBlock:(BannerViewTouchImageBlock)block;

@end
