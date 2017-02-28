//
//  OrderDetailOrderNoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailOrderNoView.h"

@implementation OrderDetailOrderNoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbOrderNo = [[UILabel alloc] init];
        _lbOrderNo.font = Font(13);
        [self addSubview:_lbOrderNo];
        [_lbOrderNo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-60);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];

        
        _lbDetail = [[UILabel alloc] init];
        _lbDetail.text = @"详情";
        _lbDetail.textColor = Blue_Color;
        _lbDetail.textAlignment = NSTextAlignmentRight;
        _lbDetail.font = Font(12);
        [self addSubview:_lbDetail];
        [_lbDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];

        
        _button = [[UIButton alloc] init];
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setOrderNo:(NSString *)orderNo
{
    _lbOrderNo.text = [NSString stringWithFormat:@"订单号：%@", orderNo];
}

- (void)setOrderType:(NSNumber *)orderType
{
    _orderType = orderType;
    
    NSInteger value = orderType.integerValue;
    if(value==0)
    {
        _lbOrderNo.textColor = Secondary_Text_Color2;
        
        _lbDetail.hidden = YES;
        self.button.enabled = NO;
    }
    else if(value==1)
    {
        _lbOrderNo.textColor = Main_Text_Color;
        
        _lbDetail.hidden = YES;
        self.button.enabled = NO;
    }
    else
    {
        _lbOrderNo.textColor = Main_Text_Color;
        
        _lbDetail.hidden = NO;
        self.button.enabled = YES;
    }
}

@end
