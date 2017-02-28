//
//  TagSelectCell.m
//  xbed
//
//  Created by Leo.Chen on 16/8/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TagSelectCell.h"

@implementation TagSelectCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 13;
        self.layer.borderWidth = LINE_WIDTH;
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(12);
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(frame.size.width);
            make.height.mas_equalTo(frame.size.height);
            make.center.mas_equalTo(0);
            
        }];
    }
    
    return self;
}

- (void)setModel:(TagModel *)model
{
    _model = model;
    
    _lbTitle.text = model.name;
    
    [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(model.name.length*12+24);
        
    }];
}

- (void)setStates:(NSInteger)states
{
    _states = states;
    
    if(states==1)//选中
    {
        self.layer.borderColor = Blue_Color.CGColor;
        _lbTitle.textColor = Blue_Color;
    }
    else//未选中
    {
        self.layer.borderColor = Secondary_Text_Color2.CGColor;
        _lbTitle.textColor = Main_Text_Color;
    }
}

@end
