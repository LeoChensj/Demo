//
//  OrderListStateSelectCell.m
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderListStateSelectCell.h"

@implementation OrderListStateSelectCell

- (instancetype)init
{
    if(self = [super init])
    {
        [self setTitleColor:Secondary_Text_Color forState:UIControlStateNormal];
        self.titleLabel.font = Font(13);
        
        _vRed = [[UIView alloc] init];
        _vRed.layer.masksToBounds = YES;
        _vRed.layer.cornerRadius = 4;
        _vRed.backgroundColor = Red_Color;
        [self addSubview:_vRed];
        [_vRed mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(8);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(10);
            
        }];
        _vRed.hidden = YES;
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setStates:(NSInteger)states
{
    _states = states;
    
    if(states==1)
    {
        [self setTitleColor:Blue_Color forState:UIControlStateNormal];
    }
    else
    {
        [self setTitleColor:Secondary_Text_Color forState:UIControlStateNormal];
    }
}

- (void)setIsNew:(BOOL)isNew
{
    _isNew = isNew;
    
    _vRed.hidden = !isNew;
}

@end
