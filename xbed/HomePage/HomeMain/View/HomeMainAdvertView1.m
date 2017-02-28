//
//  HomeMainAdvertView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomeMainAdvertView1.h"
#import "WebViewController.h"

@implementation HomeMainAdvertView1

- (void)setDataArray:(NSArray<AdvertModel *> *)dataArray
{
    _dataArray = dataArray;
    
    NSInteger count = dataArray.count;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo((180+10)*count);
        
    }];
    
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    for (NSInteger i=0;i<dataArray.count;i++)
    {
        AdvertView *advertView = [[AdvertView alloc] init];
        advertView.layer.masksToBounds = YES;
        advertView.layer.cornerRadius = 2;
        advertView.model = dataArray[i];
        [self addSubview:advertView];
        [advertView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(180);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo((180+10)*i);
            
        }];
    }
}

@end
