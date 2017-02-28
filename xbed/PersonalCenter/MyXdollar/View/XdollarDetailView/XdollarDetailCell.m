//
//  XdollarDetailCell.m
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XdollarDetailCell.h"

@implementation XdollarDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(14);
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(self.mas_centerY).offset(-5);
            
        }];
        
        
        _lbDate = [[UILabel alloc] init];
        _lbDate.textColor = Secondary_Text_Color2;
        _lbDate.font = Font(12);
        [self.contentView addSubview:_lbDate];
        [_lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.mas_centerY).offset(5);
            
        }];
        
        
        
        _lbValue = [[UILabel alloc] init];
        _lbValue.textAlignment = NSTextAlignmentRight;
        _lbValue.font = Font(18);
        [self.contentView addSubview:_lbValue];
        [_lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(18);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}


- (void)setModel:(XdollarModel *)model
{
    _model = model;
    
    _lbTitle.text = model.title;
    _lbDate.text = [NSString stringWithFormat:@"%ld-%02ld-%02ld", model.createdAt.year, model.createdAt.month, model.createdAt.day];
    
    if(model.accrual.floatValue>=0)
    {
        _lbValue.textColor = Blue_Color;
        _lbValue.text = [NSString stringWithFormat:@"+%@", [NSNumber numberWithFloat:model.accrual.integerValue*0.01]];
    }
    else
    {
        _lbValue.textColor = Red_Color;
        _lbValue.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithFloat:model.accrual.integerValue*0.01]];
    }
    
}



@end
