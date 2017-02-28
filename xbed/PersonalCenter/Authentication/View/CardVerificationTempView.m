//
//  CardVerificationTempView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CardVerificationTempView.h"

@implementation CardVerificationTempView

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
//        _lb1 = [[UILabel alloc] init];
//        _lb1.text = @"身份证正面";
//        _lb1.textColor = [UIColor whiteColor];
//        _lb1.textAlignment = NSTextAlignmentCenter;
//        _lb1.font = Font(14);
//        [self addSubview:_lb1];
//        [_lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.width.mas_equalTo(80);
//            make.height.mas_equalTo(14);
//            make.centerX.mas_equalTo(0);
//            make.top.mas_equalTo(60);
//            
//        }];
//        
//        _imgv1 = [[UIImageView alloc] init];
//        _imgv1.image = [UIImage imageNamed:@"img_id_card_face"];
//        [self addSubview:_imgv1];
//        [_imgv1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-75);
//            make.height.mas_equalTo((MAIN_SCREEN_WIDTH-75)*9/12);
//            make.centerX.mas_equalTo(0);
//            make.top.mas_equalTo(_lb1.mas_bottom).offset(10);
//            
//        }];
        
        
        _imgv2 = [[UIImageView alloc] init];
        _imgv2.image = [UIImage imageNamed:@"img_id_card_hand"];
        [self addSubview:_imgv2];
        [_imgv2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-75);
            make.height.mas_equalTo((MAIN_SCREEN_WIDTH-75)*9/12);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _lb2 = [[UILabel alloc] init];
        _lb2.text = @"手持身份证正面照";
        _lb2.textColor = [UIColor whiteColor];
        _lb2.textAlignment = NSTextAlignmentCenter;
        _lb2.font = Font(14);
        [self addSubview:_lb2];
        [_lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(_imgv2.mas_top).offset(-15);
            
        }];
        
        
        
        _lbRemind = [[UILabel alloc] init];
        _lbRemind.text = @"（请确保姓名、身份证号清晰）";
        _lbRemind.textColor = [UIColor whiteColor];
        _lbRemind.textAlignment = NSTextAlignmentCenter;
        _lbRemind.font = Font(12);
        [self addSubview:_lbRemind];
        [_lbRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-20);
            
        }];
        
        WS(ws);
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws close];
            
        }];
        
    }
    
    return self;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)close
{
    [self removeFromSuperview];
}


@end
