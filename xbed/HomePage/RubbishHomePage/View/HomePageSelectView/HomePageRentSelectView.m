//
//  HomePageRentSelectView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomePageRentSelectView.h"

@implementation HomePageRentSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _lbShortRent = [[UILabel alloc] init];
        _lbShortRent.text = @"小住";
        _lbShortRent.textAlignment = NSTextAlignmentCenter;
        _lbShortRent.font = FontBold(18);
        [self addSubview:_lbShortRent];
        [_lbShortRent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(25);
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(self.mas_left).offset((MAIN_SCREEN_WIDTH-20)/4);
            
        }];
        
        _lbLongRent = [[UILabel alloc] init];
        _lbLongRent.text = @"长留";
        _lbLongRent.textAlignment = NSTextAlignmentCenter;
        _lbLongRent.font = FontBold(18);
        [self addSubview:_lbLongRent];
        [_lbLongRent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(25);
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(self.mas_right).offset(-(MAIN_SCREEN_WIDTH-20)/4);
            
        }];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = Seg_Line_Color;
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(LINE_WIDTH);
            make.height.mas_equalTo(20);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = Seg_Line_Color;
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
        _vIndex = [[UIView alloc] initWithFrame:CGRectMake(((MAIN_SCREEN_WIDTH-20)/2-117)/2, 52-2, 117, 2)];
        _vIndex.backgroundColor = Blue_Color;
        _vIndex.layer.masksToBounds = YES;
        _vIndex.layer.cornerRadius = 1;
        [self addSubview:_vIndex];
        
        
        
        
        UIButton *btn1 = [[UIButton alloc] init];
        [self addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH-20)/2);
            make.height.mas_equalTo(52);
            make.left.top.mas_equalTo(0);
            
        }];
        
        UIButton *btn2 = [[UIButton alloc] init];
        [self addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo((MAIN_SCREEN_WIDTH-20)/2);
            make.height.mas_equalTo(52);
            make.right.top.mas_equalTo(0);
            
        }];
        
        
        WS(ws);
        [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            ws.index = 0;
            
        }];
        
        [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            ws.index = 1;
            
        }];
        
        
        self.index = 0;
    }
    
    return self;
}



- (void)setIndex:(NSInteger)index
{
    _index = index;
    
    if(index==0)
    {
        _lbShortRent.textColor = Blue_Color;
        _lbLongRent.textColor = Main_Text_Color;
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _vIndex.origin = CGPointMake(((MAIN_SCREEN_WIDTH-20)/2-117)/2, 52-2);
            
        }];
    }
    else if(index==1)
    {
        _lbShortRent.textColor = Main_Text_Color;
        _lbLongRent.textColor = Blue_Color;
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _vIndex.origin = CGPointMake(((MAIN_SCREEN_WIDTH-20)/2-117)/2+(MAIN_SCREEN_WIDTH-20)/2, 52-2);
            
        }];
    }
}






@end
