//
//  RoomPriceSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomPriceSelectView.h"

@implementation RoomPriceSelectView

- (instancetype)initWithRentType:(NSInteger)rentType
{
    if(self = [super init])
    {
        self.rentType = rentType;
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"价格范围";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = FontBold(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14);
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            
        }];
        
        _slider = [[RangeSlider alloc] initWithFrame:CGRectMake(15, 30, MAIN_SCREEN_WIDTH-30, 50)];
        _slider.limitMin = 0;
        
        _slider.imageThumb = @"ic_price_thumb";
        _slider.trackNormalColor = Secondary_Text_Color2;
        _slider.trackSelectColor = Blue_Color;
        _slider.trackNormalHeight = 4;
        _slider.trackSelectHeight = 8;
        
        if(self.rentType==0)//短租
        {
            _slider.limitMax = 1000*100;
            _slider.interval = 100*100;
        }
        else//长租
        {
            _slider.limitMax = 10000*100;
            _slider.interval = 1000*100;
        }
        
        [self addSubview:_slider];
        
        
        WS(ws);
        [[_slider rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(NSNumber *x) {
            
            if(ws.slider.valueMin==ws.slider.limitMin)
            {
                ws.minPrice = nil;
            }
            else
            {
                ws.minPrice = [NSNumber numberWithInteger:ws.slider.valueMin];
            }
            
            if(ws.slider.valueMax==ws.slider.limitMax)
            {
                ws.maxPrice = nil;
            }
            else
            {
                ws.maxPrice = [NSNumber numberWithInteger:ws.slider.valueMax];
            }
        }];
        
        
        _lbMinPrice = [[UILabel alloc] init];
        _lbMinPrice.textColor = Blue_Color;
        _lbMinPrice.textAlignment = NSTextAlignmentLeft;
        _lbMinPrice.font = [UIFont fontWithName:GlobalFontName size:12];
        [self addSubview:_lbMinPrice];
        [_lbMinPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
            make.left.mas_equalTo(15);
            
        }];
        
        _lbMaxPrice = [[UILabel alloc] init];
        _lbMaxPrice.textColor = Blue_Color;
        _lbMaxPrice.textAlignment = NSTextAlignmentRight;
        _lbMaxPrice.font = [UIFont fontWithName:GlobalFontName size:12];
        [self addSubview:_lbMaxPrice];
        [_lbMaxPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(12);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
            make.right.mas_equalTo(-15);
            
        }];
        
        
        [RACObserve(self, minPrice) subscribeNext:^(NSNumber *x) {

            if(x)
            {
                ws.slider.valueMin = x.integerValue;
                ws.lbMinPrice.text = [NSString stringWithFormat:@"￥%ld", x.integerValue/100];
            }
            else
            {
                ws.slider.valueMin = ws.slider.limitMin;
                ws.lbMinPrice.text = [NSString stringWithFormat:@"￥%ld", ws.slider.limitMin/100];
            }

        }];
        
        [RACObserve(self, maxPrice) subscribeNext:^(NSNumber *x) {
            
            if(x)
            {
                ws.slider.valueMax = x.integerValue;
                ws.lbMaxPrice.text = [NSString stringWithFormat:@"￥%ld", x.integerValue/100];
            }
            else
            {
                ws.slider.valueMax = ws.slider.limitMax;
                //ws.lbMaxPrice.text = [NSString stringWithFormat:@"￥%ld", ws.slider.limitMax/100];
                ws.lbMaxPrice.text = @"不限";
            }
            
        }];
        
    }
    
    return self;
}


- (void)reset
{
    self.minPrice = nil;
    self.maxPrice = nil;
}


@end
