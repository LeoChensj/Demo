//
//  OrderPriceDetailCell.m
//  xbed
//
//  Created by Leo.Chen on 16/9/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderPriceDetailCell.h"

@implementation OrderPriceDetailCell

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
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-210);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(25);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _lbValue = [[UILabel alloc] init];
        _lbValue.textColor = Main_Text_Color;
        _lbValue.textAlignment = NSTextAlignmentRight;
        _lbValue.font = Font(13);
        [self addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(13);
            make.right.mas_equalTo(-25);
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
        
        self.haveLine = NO;
        
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
