//
//  CheckinInfoConfirmDateView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinInfoConfirmDateView.h"

@implementation CheckinInfoConfirmDateView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _dateSelectView = [[DateSelectView alloc] init];
        [self addSubview:_dateSelectView];
        [_dateSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(70);
            make.top.left.mas_equalTo(0);
            
        }];
        
        UIView *redView = [[UIView alloc] init];
        redView.backgroundColor = Light_Red_Color;
        [self addSubview:redView];
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(34);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_dateSelectView.mas_bottom).offset(0);
            
        }];
        
        _lbRemind = [[UILabel alloc] init];
        //_lbRemind.text = @"入住当天14:00后订单不可取消";
        _lbRemind.textColor = Red_Color;
        _lbRemind.font = Font(12);
        [redView addSubview:_lbRemind];
        [_lbRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        RAC(_lbRemind, text) = RACObserve([DBManager getInstance], appUITextData.checkinConfirmRemind);
        
        
    }
    
    return self;
}


- (void)setCheckinDate:(NSDate *)checkinDate
{
    _checkinDate = checkinDate;
    
    _dateSelectView.checkinDate = checkinDate;
}
- (void)setCheckoutDate:(NSDate *)checkoutDate
{
    _checkoutDate = checkoutDate;
    
    _dateSelectView.checkoutDate = checkoutDate;
}



- (UIButton *)button
{
    return _dateSelectView;
}



@end
