//
//  CheckinInfoConfirmOrderMoneyView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinInfoConfirmOrderMoneyView.h"

@implementation OrderMoneyCell

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(13);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-130);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _lbValue = [[UILabel alloc] init];
        _lbValue.textColor = Main_Text_Color;
        _lbValue.textAlignment = NSTextAlignmentRight;
        _lbValue.font = Font(13);
        [self addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(13);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
            
        }];
        _line.hidden = YES;
    }
    
    return self;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}
- (void)setAttrTitle:(NSAttributedString *)attrTitle
{
    _attrTitle = attrTitle;
    
    _lbTitle.attributedText = attrTitle;
}
- (void)setValue:(NSString *)value
{
    _value = value;
    
    _lbValue.text = value;
}
- (void)setValueColor:(UIColor *)valueColor
{
    _valueColor = valueColor;
    
    _lbValue.textColor = valueColor;
}
- (void)setHaveLine:(BOOL)haveLine
{
    _haveLine = haveLine;
    
    _line.hidden = !haveLine;
}

@end




@implementation CheckinInfoConfirmOrderMoneyView

- (instancetype)initWithRentType:(NSInteger)rentType
{
    if(self = [super init])
    {
        self.rentType = rentType;
        
        if(rentType==0)
        {
            _myHeight = 147;
        }
        else
        {
            _myHeight = 196;
        }
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        NSString *depositTitle = @"押金 （退房后退还）";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:depositTitle];
        [attrStr addAttribute:(NSString *)NSForegroundColorAttributeName value:Red_Color range:NSMakeRange(2, depositTitle.length-2)];
        
        _cellDeposit = [[OrderMoneyCell alloc] init];
        _cellDeposit.attrTitle = (NSAttributedString *)attrStr;
        [self addSubview:_cellDeposit];
        
        if(rentType==1)//长租
        {
            [_cellDeposit mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                make.height.mas_equalTo(49);
                make.left.top.mas_equalTo(0);
                
            }];
        }
        else//短租 无押金
        {
            _cellDeposit.hidden = YES;
            [_cellDeposit mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(0);
                make.height.mas_equalTo(0);
                make.left.top.mas_equalTo(0);
                
            }];
        }
        
        
        _cellTotal = [[OrderMoneyCell alloc] init];
        _cellTotal.title = @"总房费";
        [self addSubview:_cellTotal];
        [_cellTotal mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellDeposit.mas_bottom).offset(0);
            
        }];
        
        _cellDiscount = [[OrderMoneyCell alloc] init];
        _cellDiscount.title = @"优惠";
        _cellDiscount.haveLine = YES;
        [self addSubview:_cellDiscount];
        [_cellDiscount mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellTotal.mas_bottom).offset(0);
            
        }];
        
        
        _cellActual = [[OrderMoneyCell alloc] init];
        _cellActual.title = @"应付金额";
        _cellActual.valueColor = Blue_Color;
        [self addSubview:_cellActual];
        [_cellActual mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_cellDiscount.mas_bottom).offset(0);
            
        }];
        
    }
    
    return self;
}



- (void)setDeposit:(NSNumber *)deposit
{
    _deposit = deposit;
    
    _cellDeposit.value = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:deposit.floatValue*0.01]];
}
- (void)setTotalMoney:(NSNumber *)totalMoney
{
    _totalMoney = totalMoney;
    
    _cellTotal.value = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:totalMoney.floatValue*0.01]];
}
- (void)setDiscountMoney:(NSNumber *)discountMoney
{
    _discountMoney = discountMoney;
    
    _cellDiscount.value = [NSString stringWithFormat:@"－￥%@", [NSNumber numberWithFloat:discountMoney.floatValue*0.01]];
}
- (void)setActualMoney:(NSNumber *)actualMoney
{
    _actualMoney = actualMoney;
    
    _cellActual.value = [NSString stringWithFormat:@"￥%@", [NSNumber numberWithFloat:actualMoney.floatValue*0.01]];
}








@end
