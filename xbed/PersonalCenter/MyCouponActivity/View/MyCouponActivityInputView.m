//
//  MyCouponActivityInputView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyCouponActivityInputView.h"

@implementation MyCouponActivityInputView

- (instancetype)init
{
    if(self = [super init])
    {
        NSAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"输入会员卡、优惠码" attributes:@{NSForegroundColorAttributeName:Secondary_Text_Color2, NSFontAttributeName:Font(14)}];
        
        _tfCoupon = [[UITextField alloc] init];
        _tfCoupon.textColor = Main_Text_Color;
        _tfCoupon.font = Font(14);
        _tfCoupon.attributedPlaceholder = attrString;
        _tfCoupon.returnKeyType = UIReturnKeyDone;
        [self addSubview:_tfCoupon];
        [_tfCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20-30-80-10);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            
        }];
        
        
        _btnExchange = [[EnableButton alloc] init];
        _btnExchange.normalColor = Blue_Color;
        _btnExchange.unableColor = Blue_Unable_Color;
        _btnExchange.layer.masksToBounds = YES;
        _btnExchange.layer.cornerRadius = 3;
        [_btnExchange setTitle:@"兑换" forState:UIControlStateNormal];
        [_btnExchange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnExchange.titleLabel.font = Font(12);
        [self addSubview:_btnExchange];
        [_btnExchange mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-5);
            
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Blue_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
        
        
        RAC(self, code) = _tfCoupon.rac_textSignal;
        
    }
    
    return self;
}

@end
