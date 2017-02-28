//
//  ScreenRoomHeadView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenRoomHeadView.h"

@implementation ScreenRoomHeadView

@synthesize title = _title;
@synthesize btnTitle = _btnTitle;

- (instancetype)init
{
    if(self = [super init])
    {
        _imgvDown = [[UIImageView alloc] init];
        _imgvDown.image = [UIImage imageNamed:@"ic_down"];
        [self addSubview:_imgvDown];
        [_imgvDown mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(9);
            make.height.mas_equalTo(4);
            make.centerY.mas_equalTo(_lbTitle.mas_centerY).offset(1);
            
        }];
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
    
    CGSize sizeTitle = [_lbTitle labelSize:150];
    [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(sizeTitle.width);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(10);
        
    }];
    
    [_imgvDown mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(_lbTitle.mas_right).offset(8);
        
    }];
}


- (UIButton *)btnTitle
{
    if(_btnTitle==nil)
    {
        _btnTitle = [[UIButton alloc] init];
        [self addSubview:_btnTitle];
        [_btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(44);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(20);
            
        }];
        
    }
    
    return _btnTitle;
}



@end
