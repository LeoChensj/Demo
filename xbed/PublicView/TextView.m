//
//  TextView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TextView.h"

@implementation TextView

- (instancetype)init
{
    if(self = [super init])
    {
        _vPoint = [[UIView alloc] init];
        _vPoint.layer.masksToBounds = YES;
        _vPoint.layer.cornerRadius = 2.5;
        [self addSubview:_vPoint];
        [_vPoint mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(5);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(5);
            
        }];
        
        _lbContent = [[UILabel alloc] init];
        _lbContent.numberOfLines = 0;
        _lbContent.font = Font(13);
        [self addSubview:_lbContent];
        [_lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(0);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(_vPoint.mas_right).offset(10);
            make.top.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setContent:(NSString *)content
{
    _content = content;
    
    _lbContent.text = content;
    _lbContent.lineSpace = 6;
    
    CGSize sizeContent = [_lbContent labelSize:MAIN_SCREEN_WIDTH-30-5-10];
    _height = sizeContent.height;
    
    [_lbContent mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(_contentWidth-5-10);
        make.height.mas_equalTo(_height);
        
    }];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_height);
        
    }];
    
}

- (void)setPointColor:(UIColor *)pointColor
{
    _pointColor = pointColor;
    
    _vPoint.backgroundColor = pointColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    
    _lbContent.textColor = textColor;
}


@end
