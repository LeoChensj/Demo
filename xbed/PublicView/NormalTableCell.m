//
//  NormalTableCell.m
//  xbed
//
//  Created by Leo.Chen on 16/7/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "NormalTableCell.h"

@implementation NormalTableCell

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = White_Click_COLOR;
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(13);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _lbValue = [[UILabel alloc] init];
        _lbValue.textColor = Main_Text_Color;
        _lbValue.textAlignment = NSTextAlignmentRight;
        _lbValue.font = Font(13);
        [self addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-100-30);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(-30);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        
        _imgvArrow = [[UIImageView alloc] init];
        _imgvArrow.image = [UIImage imageNamed:@"ic_search_into"];
        [self addSubview:_imgvArrow];
        [_imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = Seg_Line_Color;
        [self addSubview:_vLine];
        [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    _lbTitle.textColor = titleColor;
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
    
    _vLine.hidden = !haveLine;
}
- (void)setHaveArrow:(BOOL)haveArrow
{
    _haveArrow = haveArrow;
    
    if(haveArrow)
    {
        _imgvArrow.hidden = NO;
        
        [_lbValue mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-30);
            
        }];
        
    }
    else
    {
        _imgvArrow.hidden = YES;
        
        [_lbValue mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-10);
            
        }];
    }
}


@end
