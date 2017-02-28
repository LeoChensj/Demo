//
//  CouponCollectionHeaderView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CouponCollectionHeaderView.h"

@implementation CouponCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = Gray_Color;
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH-20-124)*0.5);
            make.height.mas_equalTo(LINE_WIDTH);
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            
        }];
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = Gray_Color;
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH-20-124)*0.5);
            make.height.mas_equalTo(LINE_WIDTH);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"以下优惠券不可用";
        _lbTitle.textColor = Secondary_Text_Color2;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(12);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(line1.mas_centerY).offset(0);
            
        }];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}

@end
