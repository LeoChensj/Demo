//
//  MyXdollarBaseInfoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyXdollarBaseInfoView.h"

@implementation MyXdollarBaseInfoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Blue_Color;
        
        _imgvCircle = [[UIImageView alloc] init];
        _imgvCircle.image = [UIImage imageNamed:@"pic_xdollar"];
        [self addSubview:_imgvCircle];
        [_imgvCircle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(91);
            make.centerX.top.mas_equalTo(0);
            
        }];
        
        
        _lbXdollar = [[UILabel alloc] init];
        _lbXdollar.textColor = [UIColor whiteColor];
        _lbXdollar.textAlignment = NSTextAlignmentCenter;
        _lbXdollar.font = Font(23);
        [_imgvCircle addSubview:_lbXdollar];
        [_lbXdollar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(23);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(-12);
            
        }];
        
        
        UILabel *lbXdollar = [[UILabel alloc] init];
        lbXdollar.text = @"Xdollar";
        lbXdollar.textColor = [UIColor whiteColor];
        lbXdollar.textAlignment = NSTextAlignmentCenter;
        lbXdollar.font = Font(13);
        [_imgvCircle addSubview:lbXdollar];
        [lbXdollar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(13);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(15);
            
        }];
        
        
        _lbArrived = [[UILabel alloc] init];
        _lbArrived.textColor = [UIColor whiteColor];
        _lbArrived.textAlignment = NSTextAlignmentCenter;
        _lbArrived.font = Font(14);
        [self addSubview:_lbArrived];
        [_lbArrived mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_imgvCircle.mas_bottom).offset(15);
            
        }];
        
        
        _waveView = [WXWaveView addToView:self withFrame:CGRectMake(0, 186-10, MAIN_SCREEN_WIDTH, 10)];
        _waveView.backgroundColor  = Blue_Color;
        _waveView.waveColor = Light_Blue_Color;
        _waveView.waveTime = 0;
        _waveView.waveSpeed = 2;
        _waveView.angularSpeed = 1;
        [_waveView wave];
        
    }
    
    return self;
}


- (void)setXdollar:(NSNumber *)xdollar
{
    _xdollar = xdollar;
    
    _lbXdollar.text = [NSNumber numberWithFloat:xdollar.integerValue*0.01].stringValue;
    _lbArrived.text = [NSString stringWithFormat:@"可抵%@元", [NSNumber numberWithFloat:xdollar.integerValue*0.01]];
}


@end
