//
//  CalendarCell3.m
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalendarCell3.h"

@implementation CalendarCell3

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(14);
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(frame.size.width);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(-10);
            
        }];
        
        
        _lbPrice = [[UILabel alloc] init];
        _lbPrice.textAlignment = NSTextAlignmentCenter;
        _lbPrice.font = Font(9);
        [self.contentView addSubview:_lbPrice];
        [_lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(frame.size.width);
            make.height.mas_equalTo(9);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(10);
            
        }];
        
    }
    
    return self;
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    
    if(date)
    {
        _lbTitle.hidden = NO;
        _lbPrice.hidden = NO;
        
        _lbTitle.text = [NSString stringWithFormat:@"%ld", date.day];
    }
    else
    {
        _lbTitle.hidden = YES;
        _lbPrice.hidden = YES;
    }
}

- (void)setPrice:(NSNumber *)price
{
    _price = price;
    
    if(price.integerValue==-999)
    {
        _lbPrice.text = nil;
    }
    else
    {
        _lbPrice.text = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:(price.floatValue/100)]];
    }
}


- (void)setState:(CalendarCellState3)state
{
    _state = state;
    
    switch (state)
    {
        case CalendarCellNull3:
        {
            self.contentView.backgroundColor = [UIColor whiteColor];
            _lbTitle.hidden = YES;
            _lbPrice.hidden = YES;
        }
        case CalendarCellOver3:
        {
            _lbTitle.hidden = NO;
            _lbPrice.hidden = YES;
            
            self.contentView.backgroundColor = [UIColor whiteColor];
            _lbTitle.textColor = Secondary_Text_Color2;
            
            [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(0);
                
            }];
            
            //self.date = _date;
            
            break;
        }
        case CalendarCellNormal3:
        {
            _lbTitle.hidden = NO;
            _lbPrice.hidden = NO;
            
            self.contentView.backgroundColor = [UIColor whiteColor];
            _lbTitle.textColor = Main_Text_Color;
            _lbPrice.textColor = Secondary_Text_Color;
            
            [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(-7);
                
            }];
            
            [_lbPrice mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(7);
                
            }];
            
            self.date = _date;
            self.price = _price;
            
            break;
        }
        case CalendarCellUnbook3:
        {
            _lbTitle.hidden = NO;
            _lbPrice.hidden = NO;
            
            self.contentView.backgroundColor = Background_Color;
            _lbTitle.textColor = Secondary_Text_Color2;
            _lbPrice.textColor = Secondary_Text_Color2;
            
            [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(-7);
                
            }];
            
            [_lbPrice mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(7);
                
            }];
            
            self.date = _date;
            self.price = _price;
            _lbPrice.text = @"已订";
            
            break;
        }
        case CalendarCellCheckin3:
        {
            _lbTitle.hidden = NO;
            _lbPrice.hidden = YES;
            
            self.contentView.backgroundColor = Blue_Color;
            _lbTitle.textColor = [UIColor whiteColor];
            _lbTitle.text = @"入住";
            
            [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(0);
                
            }];
            
            break;
        }
        case CalendarCellCheckout3:
        {
            _lbTitle.hidden = NO;
            _lbPrice.hidden = YES;
            
            self.contentView.backgroundColor = Blue_Color;
            _lbTitle.textColor = [UIColor whiteColor];
            _lbTitle.text = @"退房";
            
            [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(0);
                
            }];
            
            break;
        }
        case CalendarCellBetween3:
        {
            _lbTitle.hidden = NO;
            _lbPrice.hidden = NO;
            
            self.contentView.backgroundColor = Light_Blue_Color;
            _lbTitle.textColor = Blue_Color;
            _lbPrice.textColor = Blue_Color;
            
            [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(-7);
                
            }];
            
            [_lbPrice mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(7);
                
            }];
            
            self.date = _date;
            self.price = _price;
            
            break;
        }
    }
}



@end
