//
//  HomeMainCityHeadView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomeMainCityHeadView.h"

@implementation HomeMainCityHeadView

- (instancetype)init
{
    if(self = [super init])
    {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"热门目的地";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(18);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(97);
            make.height.mas_equalTo(18);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _view1 = [[UIView alloc] init];
        _view1.backgroundColor = Main_Text_Color;
        [self addSubview:_view1];
        [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(2);
            make.right.mas_equalTo(_lbTitle.mas_left).offset(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _view2 = [[UIView alloc] init];
        _view2.backgroundColor = Main_Text_Color;
        [self addSubview:_view2];
        [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(2);
            make.left.mas_equalTo(_lbTitle.mas_right).offset(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

@end
