//
//  LeoAdPageView.m
//  xbed
//
//  Created by Leo.Chen on 2017/1/13.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "LeoAdPageView.h"

@implementation LeoAdPageView

- (instancetype)init
{
    if(self = [super init])
    {
        _imgvAd = [[UIImageView alloc] init];
        _imgvAd.clipsToBounds = YES;
        _imgvAd.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgvAd];
        [_imgvAd mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_height);
            make.left.top.mas_equalTo(0);
            
        }];
        
        
        
        
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    _imgvAd.image = image;
}




- (void)close
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}

@end
