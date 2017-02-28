//
//  CalendarCell2.m
//  xbed
//
//  Created by Leo.Chen on 16/8/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalendarCell2.h"

@implementation CalendarCell2

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

- (void)setState:(CalendarCellState2)state
{
    _state = state;
    
    switch (state)
    {
        case CalendarCellNull2:
        {
            self.contentView.backgroundColor = [UIColor whiteColor];
            _lbTitle.hidden = YES;
            _lbPrice.hidden = YES;
        }
        case CalendarCellOver2:
        {
            _lbTitle.hidden = NO;
            _lbPrice.hidden = YES;
            
            self.contentView.backgroundColor = [UIColor whiteColor];
            _lbTitle.textColor = Secondary_Text_Color2;
            
            [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(0);
                
            }];
            
            
            break;
        }
        case CalendarCellNormal2:
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
            
            self.price = _price;
            
            break;
        }
        case CalendarCellUnbook2:
        {
            _lbTitle.hidden = NO;
            _lbPrice.hidden = NO;
            
            self.contentView.backgroundColor = Background_Color;
            _lbTitle.textColor = Secondary_Text_Color2;
            _lbPrice.textColor = Secondary_Text_Color2;
            _lbPrice.text = @"已订";
            
            [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(-7);
                
            }];
            
            [_lbPrice mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(7);
                
            }];
            
            break;
        }
    }
}




@end
