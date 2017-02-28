//
//  HomeMainAdvertView2.m
//  xbed
//
//  Created by Leo.Chen on 16/8/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomeMainAdvertView2.h"

@implementation HomeMainAdvertView2

- (void)setDataArray:(NSArray<AdvertModel *> *)dataArray
{
    _dataArray = dataArray;
    
    NSInteger count = dataArray.count;
    NSInteger allRow = count/2+(count%2 ? 1 : 0);
    
    //NSLog(@"count=%ld, allRow=%ld", count, allRow);
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo((121*XSCALE+10)*allRow);
        
    }];
    
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    for (NSInteger i=0;i<count;i++)
    {
        NSInteger row = i/2;    //第几行
        NSInteger column = i%2; //第几列

        AdvertView *advertView = [[AdvertView alloc] init];
        advertView.layer.masksToBounds = YES;
        advertView.layer.cornerRadius = 2;
        advertView.model = dataArray[i];
        [self addSubview:advertView];
        [advertView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo((MAIN_SCREEN_WIDTH-30)/2);
            make.height.mas_equalTo(121*XSCALE);
            make.left.mas_equalTo(((MAIN_SCREEN_WIDTH-30)/2+10)*column);
            make.top.mas_equalTo((121*XSCALE+10)*row);
            
        }];
    }
}

@end
