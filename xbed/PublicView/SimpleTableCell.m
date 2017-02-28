//
//  SimpleTableCell.m
//  xbed
//
//  Created by Leo.Chen on 16/7/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = White_Click_COLOR;
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(20);
            make.center.mas_equalTo(0);
            
        }];
        
        
        _vLine1 = [[UIView alloc] init];
        _vLine1.backgroundColor = Seg_Line_Color;
        [self addSubview:_vLine1];
        [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.top.mas_equalTo(0);
            
        }];
        
        _vLine2 = [[UIView alloc] init];
        _vLine2.backgroundColor = Seg_Line_Color;
        [self addSubview:_vLine2];
        [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
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
- (void)setHaveLine1:(BOOL)haveLine1
{
    _haveLine1 = haveLine1;
    
    _vLine1.hidden = !haveLine1;
}
- (void)setHaveLine2:(BOOL)haveLine2
{
    _haveLine2 = haveLine2;
    
    _vLine2.hidden = !haveLine2;
}

@end
