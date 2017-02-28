//
//  AdvertView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "AdvertView.h"
#import "WebViewController.h"

@implementation AdvertView

- (instancetype)init
{
    if(self = [super init])
    {
        self.clipsToBounds = YES;
        
        _imgvAdvert = [[UIImageView alloc] init];
        _imgvAdvert.contentMode = UIViewContentModeScaleAspectFill;
        _imgvAdvert.clipsToBounds = YES;
        [self addSubview:_imgvAdvert];
        [_imgvAdvert mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(self);
            make.left.top.mas_equalTo(0);
            
        }];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = [UIColor whiteColor];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(14);
            make.center.mas_equalTo(0);
            
        }];
        _lbTitle.hidden = YES;
        
        
        [RACObserve(self, model) subscribeNext:^(AdvertModel *x) {
            
            _lbTitle.text = x.title;
            
            [_imgvAdvert sd_setImageWithURL:[NSURL URLWithString:x.imageUrl] placeholderImage:PlaceholderImage];
            
        }];
        
        
        
        UIButton *button = [[UIButton alloc] init];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(self);
            make.left.top.mas_equalTo(0);
            
        }];
        
        
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            WebViewController *webVC = [[WebViewController alloc] init];
            webVC.url = _model.url;
            [[RootViewController getInstance] pushViewController:webVC animated:YES];
        }];
        
    }
    
    return self;
}

@end
