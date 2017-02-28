//
//  DateSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "DateSelectView.h"

@implementation DateSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lbCheckin = [[UILabel alloc] init];
        lbCheckin.text = @"入住";
        lbCheckin.textColor = Main_Text_Color;
        lbCheckin.textAlignment = NSTextAlignmentCenter;
        lbCheckin.font = Font(12);
        [self addSubview:lbCheckin];
        [lbCheckin mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(-MAIN_SCREEN_WIDTH/4);
            make.bottom.mas_equalTo(self.mas_centerY).offset(-7);
            
        }];
        
        UILabel *lbCheckout = [[UILabel alloc] init];
        lbCheckout.text = @"退房";
        lbCheckout.textColor = Main_Text_Color;
        lbCheckout.textAlignment = NSTextAlignmentCenter;
        lbCheckout.font = Font(12);
        [self addSubview:lbCheckout];
        [lbCheckout mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(MAIN_SCREEN_WIDTH/4);
            make.bottom.mas_equalTo(self.mas_centerY).offset(-7);
            
        }];
        
        
        _lbCheckinDate = [[UILabel alloc] init];
        _lbCheckinDate.textColor = Blue_Color;
        _lbCheckinDate.textAlignment = NSTextAlignmentCenter;
        _lbCheckinDate.font = Font(13);
        [self addSubview:_lbCheckinDate];
        [_lbCheckinDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(13);
            make.centerX.mas_equalTo(-MAIN_SCREEN_WIDTH/4);
            make.top.mas_equalTo(self.mas_centerY).offset(7);
            
        }];
        
        _lbCheckoutDate = [[UILabel alloc] init];
        _lbCheckoutDate.textColor = Blue_Color;
        _lbCheckoutDate.textAlignment = NSTextAlignmentCenter;
        _lbCheckoutDate.font = Font(13);
        [self addSubview:_lbCheckoutDate];
        [_lbCheckoutDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(13);
            make.centerX.mas_equalTo(MAIN_SCREEN_WIDTH/4);
            make.top.mas_equalTo(self.mas_centerY).offset(7);
            
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Background_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(50);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
        self.checkinDate = nil;
        self.checkoutDate = nil;
        
    }
    
    return self;
}


- (void)setCheckinDate:(NSDate *)checkinDate
{
    _checkinDate = checkinDate;
    
    if(checkinDate==nil)
    {
        _lbCheckinDate.text = @"选择日期";
    }
    else
    {
        _lbCheckinDate.text = [NSString stringWithFormat:@"%ld-%02ld-%02ld", checkinDate.year, checkinDate.month, checkinDate.day];
    }
}

- (void)setCheckoutDate:(NSDate *)checkoutDate
{
    _checkoutDate = checkoutDate;
    
    if(checkoutDate==nil)
    {
        _lbCheckoutDate.text = @"选择日期";
    }
    else
    {
        _lbCheckoutDate.text = [NSString stringWithFormat:@"%ld-%02ld-%02ld", checkoutDate.year, checkoutDate.month, checkoutDate.day];
    }
}






@end
