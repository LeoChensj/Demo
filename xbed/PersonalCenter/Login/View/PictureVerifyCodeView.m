//
//  PictureVerifyCodeView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PictureVerifyCodeView.h"

#define PictureVerifyCodeViewWidth (MAIN_SCREEN_WIDTH-90)

@implementation PictureVerifyCodeView

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        self.flag = YES;
        
        _vContent = [[UIView alloc] init];
        _vContent.layer.masksToBounds = YES;
        _vContent.layer.cornerRadius = 3;
        _vContent.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vContent];
        [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(PictureVerifyCodeViewWidth);
            make.height.mas_equalTo(200);
            make.center.mas_equalTo(0);
            
        }];
        
        
        UIImageView *imgvClose = [[UIImageView alloc] init];
        imgvClose.image = [UIImage imageNamed:@"ic_code_close"];
        [self addSubview:imgvClose];
        [imgvClose mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(24);
            make.right.mas_equalTo(-35);
            make.bottom.mas_equalTo(_vContent.mas_top).offset(-15);
            
        }];
        
        
        UIButton *btnClose = [[UIButton alloc] init];
        [self addSubview:btnClose];
        [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(30);
            make.centerX.mas_equalTo(imgvClose.mas_centerX).offset(0);
            make.centerY.mas_equalTo(imgvClose.mas_centerY).offset(0);
            
        }];
        [btnClose addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
//        UIButton *btnClose1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, (MAIN_SCREEN_HEIGHT-200)*0.5)];
//        [self addSubview:btnClose1];
//        [btnClose1 addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIButton *btnClose2 = [[UIButton alloc] initWithFrame:CGRectMake(0, (MAIN_SCREEN_HEIGHT-200)*0.5+200, MAIN_SCREEN_WIDTH, (MAIN_SCREEN_HEIGHT-200)*0.5)];
//        [self addSubview:btnClose2];
//        [btnClose2 addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        _imgvCode = [[UIImageView alloc] init];
        _imgvCode.backgroundColor = Background_Color;
        _imgvCode.clipsToBounds = YES;
        _imgvCode.layer.masksToBounds = YES;
        _imgvCode.layer.cornerRadius = 2;
        [_vContent addSubview:_imgvCode];
        [_imgvCode mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(95);
            make.height.mas_equalTo(35);
            make.top.mas_equalTo(35);
            make.left.mas_equalTo(50*XSCALE);
            
        }];
        
        
        _btnChange = [[UIButton alloc] init];
        [_btnChange setTitle:@"看不清？换一个" forState:UIControlStateNormal];
        [_btnChange setTitleColor:Blue_Color forState:UIControlStateNormal];
        _btnChange.titleLabel.font = Font(12);
        [_vContent addSubview:_btnChange];
        [_btnChange mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(35);
            make.centerY.mas_equalTo(_imgvCode.mas_centerY).offset(0);
            make.right.mas_equalTo(-50*XSCALE);
            
        }];
        
        
        
        UIView *vCode = [[UIView alloc] init];
        vCode.backgroundColor = [UIColor whiteColor];
        vCode.layer.masksToBounds = YES;
        vCode.layer.cornerRadius = 2;
        vCode.layer.borderWidth = 1;
        vCode.layer.borderColor = Seg_Line_Color.CGColor;
        [_vContent addSubview:vCode];
        [vCode mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(PictureVerifyCodeViewWidth-100*XSCALE);
            make.height.mas_equalTo(35);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_imgvCode.mas_bottom).offset(20);
            
        }];
        
        
        NSAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"请输入图片中的验证码" attributes:@{NSForegroundColorAttributeName:Secondary_Text_Color2, NSFontAttributeName:Font(13)}];
        _tfCode = [[UITextField alloc] init];
        _tfCode.textColor = Main_Text_Color;
        _tfCode.font = Font(13);
        _tfCode.attributedPlaceholder = attrString;
        _tfCode.keyboardType = UIKeyboardTypePhonePad;
        [vCode addSubview:_tfCode];
        [_tfCode mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(PictureVerifyCodeViewWidth-100*XSCALE-10);
            make.height.mas_equalTo(30);
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        
        
        _btnConfirm = [[UIButton alloc] init];
        [_btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [_btnConfirm setTitleColor:Blue_Color forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = Font(16);
        [_vContent addSubview:_btnConfirm];
        [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(PictureVerifyCodeViewWidth);
            make.height.mas_equalTo(49);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Blue_Color;
        [_vContent addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(PictureVerifyCodeViewWidth);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_btnConfirm.mas_top).offset(0);
            
        }];
    }
    
    return self;
}


- (void)setBase64:(NSString *)base64
{
    _base64 = base64;
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:data];
    
    _imgvCode.image = image;
}

- (void)close
{
    self.flag = NO;
    [self removeFromSuperview];
}


@end
