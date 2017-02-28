//
//  CalendarCell.m
//  xbed
//
//  Created by Leo.Chen on 16/7/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CalendarCell1.h"

@implementation CalendarCell1

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
            make.height.mas_equalTo(frame.size.height);
            make.center.mas_equalTo(0);
            
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
        _lbTitle.text = [NSString stringWithFormat:@"%ld", date.day];
    }
    else
    {
        _lbTitle.hidden = YES;
    }
}

- (void)setState:(CalendarCellState)state
{
    _state = state;
    
    switch (state)
    {
        case CalendarCellNull:
        {
            self.contentView.backgroundColor = [UIColor whiteColor];
            _lbTitle.hidden = YES;
        }
        case CalendarCellOver:
        {
            _lbTitle.hidden = NO;
            self.contentView.backgroundColor = [UIColor whiteColor];
            _lbTitle.textColor = Secondary_Text_Color2;
            self.date = _date;
            
            break;
        }
        case CalendarCellNormal:
        {
            _lbTitle.hidden = NO;
            self.contentView.backgroundColor = [UIColor whiteColor];
            _lbTitle.textColor = Main_Text_Color;
            self.date = _date;
            
            break;
        }
        case CalendarCellCheckin:
        {
            _lbTitle.hidden = NO;
            self.contentView.backgroundColor = Blue_Color;
            _lbTitle.textColor = [UIColor whiteColor];
            _lbTitle.text = @"入住";
            
            break;
        }
        case CalendarCellCheckout:
        {
            _lbTitle.hidden = NO;
            self.contentView.backgroundColor = Blue_Color;
            _lbTitle.textColor = [UIColor whiteColor];
            _lbTitle.text = @"退房";
            
            break;
        }
        case CalendarCellBetween:
        {
            _lbTitle.hidden = NO;
            self.contentView.backgroundColor = Light_Blue_Color;
            _lbTitle.textColor = Blue_Color;
            self.date = _date;
            
            break;
        }
    }
}


@end
