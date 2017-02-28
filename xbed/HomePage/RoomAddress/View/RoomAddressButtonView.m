//
//  RoomAddressButtonView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomAddressButtonView.h"

@implementation RoomAddressButtonView

@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (UIButton *)button1
{
    if(_button1==nil)
    {
        _button1 = [[UIButton alloc] init];
        _button1.layer.masksToBounds = YES;
        _button1.layer.cornerRadius = 3;
        _button1.backgroundColor = Blue_Color;
        [_button1 setTitle:@"导航" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button1.titleLabel.font = Font(12);
        [self addSubview:_button1];
        [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH-40)/3);
            make.height.mas_equalTo(34);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
            
        }];
    }
    
    return _button1;
}


- (UIButton *)button2
{
    if(_button2==nil)
    {
        _button2 = [[UIButton alloc] init];
        _button2.layer.masksToBounds = YES;
        _button2.layer.cornerRadius = 3;
        _button2.backgroundColor = Blue_Color;
        [_button2 setTitle:@"小区导航" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button2.titleLabel.font = Font(12);
        [self addSubview:_button2];
        [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH-40)/3);
            make.height.mas_equalTo(34);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(_button1.mas_right).offset(10);
            
        }];
    }
    
    return _button2;
}

- (UIButton *)button3
{
    if(_button3==nil)
    {
        _button3 = [[UIButton alloc] init];
        _button3.layer.masksToBounds = YES;
        _button3.layer.cornerRadius = 3;
        _button3.backgroundColor = Blue_Color;
        [_button3 setTitle:@"停车信息" forState:UIControlStateNormal];
        [_button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button3.titleLabel.font = Font(12);
        [self addSubview:_button3];
        [_button3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH-40)/3);
            make.height.mas_equalTo(34);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            
        }];
    }
    
    return _button3;
}





@end
