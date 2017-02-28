//
//  TitleValueTableCell.m
//  xbed
//
//  Created by Leo.Chen on 16/7/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TitleValueTableCell.h"

@implementation TitleValueTableCell

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = White_Click_COLOR;
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _lbValue = [[UILabel alloc] init];
        _lbValue.textColor = Main_Text_Color;
        _lbValue.font = Font(14);
        [self addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-110);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(100);
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
- (void)setValue:(NSString *)value
{
    _value = value;
    
    _lbValue.text = value;
}
- (void)setHaveLine:(BOOL)haveLine
{
    _haveLine = haveLine;
    
    _vLine.hidden = !haveLine;
}

@end
