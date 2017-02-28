//
//  HeadView.m
//  xclear
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

@synthesize btnLeft = _btnLeft;
@synthesize btnRight = _btnRight;

- (id)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 64)])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = [UIFont fontWithName:GlobalFontName size:18];
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-160);
            make.height.mas_equalTo(20);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(10);
            
        }];
        
        
        _imgvLeft = [[UIImageView alloc] init];
        [self addSubview:_imgvLeft];
        [_imgvLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(19);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(10);
            
        }];
        
        _imgvRight = [[UIImageView alloc] init];
        [self addSubview:_imgvRight];
        [_imgvRight mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(19);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(10);
            
        }];
        
        _lbRight = [[UILabel alloc] init];
        _lbRight.textColor = Blue_Color;
        _lbRight.textAlignment = NSTextAlignmentRight;
        _lbRight.font = [UIFont fontWithName:GlobalFontName size:14];
        [self addSubview:_lbRight];
        [_lbRight mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(10);
            
        }];
        
        _vLine = [[UIView alloc] init];
        _vLine.backgroundColor = Seg_Line_Color;
        [self addSubview:_vLine];
        [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}


//Get
- (UIButton *)btnLeft
{
    if(!_btnLeft)
    {
        _btnLeft = [[UIButton alloc] init];
        _btnLeft.enabled = YES;
        [self addSubview:_btnLeft];
        [_btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(44);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(20);
            
        }];
    }
    
    return _btnLeft;
}

- (UIButton *)btnRight
{
    if(!_btnRight)
    {
        _btnRight = [[UIButton alloc] init];
        _btnRight.backgroundColor = [UIColor clearColor];
        [self addSubview:_btnRight];
        [_btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(44);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(20);
            
        }];
    }
    
    return _btnRight;
}


//Set
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

- (void)setImgLeft:(NSString *)imgLeft
{
    _imgLeft = imgLeft;
    
    _imgvLeft.image = [UIImage imageNamed:imgLeft];
}

- (void)setImgRight:(NSString *)imgRight
{
    _imgRight = imgRight;
    
    _imgvRight.image = [UIImage imageNamed:imgRight];
    _imgvRight.hidden = NO;
    _lbRight.hidden = YES;
}

- (void)setTxtRight:(NSString *)txtRight
{
    _txtRight = txtRight;
    
    _lbRight.text = txtRight;
    _lbRight.hidden = NO;
    _imgvRight.hidden = YES;
}

- (void)setSizeLeft:(CGSize)sizeLeft
{
    _sizeLeft = sizeLeft;
    
    [_imgvLeft mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(sizeLeft.width);
        make.height.mas_equalTo(sizeLeft.height);
        
    }];
}

- (void)setSizeRight:(CGSize)sizeRight
{
    _sizeRight = sizeRight;
    
    [_imgvRight mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(sizeRight.width);
        make.height.mas_equalTo(sizeRight.height);
        
    }];
}

- (void)setRightColor:(UIColor *)rightColor
{
    _rightColor = rightColor;
    
    _lbRight.textColor = rightColor;
}

- (void)setHaveLine:(BOOL)haveLine
{
    _haveLine = haveLine;
    
    _vLine.hidden = !haveLine;
}

@end
