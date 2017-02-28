//
//  LoadingView.m
//  xbed
//
//  Created by Leo.Chen on 15/12/18.
//  Copyright © 2015年 liujialin125. All rights reserved.
//

#import "LoadingView.h"
#import "UIImage+GIF.h"

@implementation LoadingView

static LoadingView *instance = nil;

+ (LoadingView *)getInstance
{
    if(instance==nil)
    {
        instance = [[LoadingView alloc] init];
        
        instance.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
        
        UITapGestureRecognizer *tapMe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStopEvent)];
        [instance addGestureRecognizer:tapMe];
        
        
        NSMutableArray *images = [NSMutableArray array];
        for(NSInteger i=0;i<25;i++)
        {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_000%02ld", i]];
            [images addObject:image];
        }
        
        instance.imageView = [[UIImageView alloc] init];
        instance.imageView.animationImages = images;
        instance.imageView.animationDuration = 0.6;
        [instance addSubview:instance.imageView];
        [instance.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(172);
            make.height.mas_equalTo(118);
            make.center.mas_equalTo(0);
            
        }];
        [instance.imageView startAnimating];
    
    }
    
    return instance;
}

+ (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:[LoadingView getInstance]];
}

+ (void)close
{
    if(instance && instance.imageView)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            instance.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [instance removeFromSuperview];
            instance.imageView = nil;
            instance = nil;
            
        }];
    }
}

+ (void)tapStopEvent
{
}

@end
