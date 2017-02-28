//
//  MonthSelectView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MonthSelectView.h"

@implementation MonthSelectView

- (instancetype)init
{
    if(self = [super init])
    {
        _imgvLeft = [[UIImageView alloc] init];
        _imgvLeft.image = [UIImage imageNamed:@"ic_details_left_blue"];
        [self addSubview:_imgvLeft];
        [_imgvLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _imgvRight = [[UIImageView alloc] init];
        _imgvRight.image = [UIImage imageNamed:@"ic_details_right_blue"];
        [self addSubview:_imgvRight];
        [_imgvRight mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)addMonth
{
    self.currentDate = [_currentDate dateByAddingMonth:1];
}

- (void)subMonth
{
    self.currentDate = [_currentDate dateByAddingMonth:-1];
}



- (void)setToday:(NSDate *)today
{
    _today = today;
    
    self.currentDate = [today dateMonthStart];
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    _currentDate = currentDate;
    
    _lbTitle.text = [NSString stringWithFormat:@"%ld-%02ld", currentDate.year, currentDate.month];
    
    if([[_today dateMonthStart] isEqualToDay:currentDate])//当前是第一个月
    {
        _imgvLeft.image = [UIImage imageNamed:@"ic_details_left_gary"];
        _imgvRight.image = [UIImage imageNamed:@"ic_details_right_blue"];
        
        self.btnLeft.enabled = NO;
        self.btnRight.enabled = YES;
    }
    else if([[_today dateMonthStart] isEqualToDay:[currentDate dateByAddingMonth:-1]])//当前是第二个月
    {
        _imgvLeft.image = [UIImage imageNamed:@"ic_details_left_blue"];
        _imgvRight.image = [UIImage imageNamed:@"ic_details_right_blue"];
        
        self.btnLeft.enabled = YES;
        self.btnRight.enabled = YES;
    }
    else if([[_today dateMonthStart] isEqualToDay:[currentDate dateByAddingMonth:-2]])//当前时第三个月
    {
        _imgvLeft.image = [UIImage imageNamed:@"ic_details_left_blue"];
        _imgvRight.image = [UIImage imageNamed:@"ic_details_right_gary"];
        
        self.btnLeft.enabled = YES;
        self.btnRight.enabled = NO;
    }
}

- (UIButton *)btnLeft
{
    if(_btnLeft==nil)
    {
        _btnLeft = [[UIButton alloc] init];
        [self addSubview:_btnLeft];
        [_btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(24);
            make.left.centerY.mas_equalTo(0);
            
        }];
    }
    
    return _btnLeft;
}

- (UIButton *)btnRight
{
    if(_btnRight==nil)
    {
        _btnRight = [[UIButton alloc] init];
        [self addSubview:_btnRight];
        [_btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(24);
            make.right.centerY.mas_equalTo(0);
            
        }];
    }
    
    return _btnRight;
}





@end
