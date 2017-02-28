//
//  PersonalCenterBaseInfoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PersonalCenterBaseInfoView.h"

@implementation PersonalCenterBaseInfoView

@synthesize btnSetting = _btnSetting;
@synthesize btnHeadImage = _btnHeadImage;
@synthesize btnLogin = _btnLogin;
@synthesize btnXdollar = _btnXdollar;
@synthesize btnActivity = _btnActivity;


- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Blue_Color;
        
        _imgvSetting = [[UIImageView alloc] init];
        _imgvSetting.image = [UIImage imageNamed:@"ic_setting"];
        [self addSubview:_imgvSetting];
        [_imgvSetting mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(19);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(30);
            
        }];
        
        
        _imgvHead = [[UIImageView alloc] init];
        _imgvHead.layer.masksToBounds = YES;
        _imgvHead.layer.cornerRadius = 45;
        _imgvHead.clipsToBounds = YES;
        _imgvHead.contentMode = UIViewContentModeScaleAspectFill;
        _imgvHead.image = PlaceholderHead;
        [self addSubview:_imgvHead];
        [_imgvHead mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(90);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(64);
            
        }];
        
        
        _lbPhone = [[UILabel alloc] init];
        _lbPhone.textColor = [UIColor whiteColor];
        _lbPhone.textAlignment = NSTextAlignmentCenter;
        _lbPhone.font = Font(14);
        [self addSubview:_lbPhone];
        [_lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_imgvHead.mas_bottom).offset(18);
            
        }];
        
        
        _lbXdollar = [[UILabel alloc] init];
        _lbXdollar.textColor = [UIColor whiteColor];
        _lbXdollar.textAlignment = NSTextAlignmentCenter;
        _lbXdollar.font = Font(14);
        [self addSubview:_lbXdollar];
        [_lbXdollar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2-20);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(-MAIN_SCREEN_WIDTH/4);
            make.top.mas_equalTo(_lbPhone.mas_bottom).offset(15);
            
        }];
        
        
        _lbActivity = [[UILabel alloc] init];
        _lbActivity.textColor = [UIColor whiteColor];
        _lbActivity.textAlignment = NSTextAlignmentCenter;
        _lbActivity.font = Font(14);
        [self addSubview:_lbActivity];
        [_lbActivity mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2-20);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(MAIN_SCREEN_WIDTH/4);
            make.top.mas_equalTo(_lbPhone.mas_bottom).offset(15);
            
        }];
        
        
        
        UILabel *lbXdollar = [[UILabel alloc] init];
        lbXdollar.text = @"Xdollar";
        lbXdollar.textColor = [UIColor whiteColor];
        lbXdollar.textAlignment = NSTextAlignmentCenter;
        lbXdollar.font = Font(12);
        [self addSubview:lbXdollar];
        [lbXdollar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(-MAIN_SCREEN_WIDTH/4);
            make.bottom.mas_equalTo(-15);
            
        }];
        
        UILabel *lbActivity = [[UILabel alloc] init];
        lbActivity.text = @"优惠券";
        lbActivity.textColor = [UIColor whiteColor];
        lbActivity.textAlignment = NSTextAlignmentCenter;
        lbActivity.font = Font(12);
        [self addSubview:lbActivity];
        [lbActivity mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(MAIN_SCREEN_WIDTH/4);
            make.bottom.mas_equalTo(-15);
            
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(LINE_WIDTH);
            make.height.mas_equalTo(32);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_lbPhone.mas_bottom).offset(15);
            
        }];
        
        _waveView = [WXWaveView addToView:self withFrame:CGRectMake(0, 250-3, MAIN_SCREEN_WIDTH, 3)];
        _waveView.backgroundColor  = Blue_Color;
        _waveView.waveColor = Light_Blue_Color;
        _waveView.waveTime = 0;
        _waveView.waveSpeed = 2;
        _waveView.angularSpeed = 1.8;
        [_waveView wave];
    }
    
    return self;
}

- (void)setIsLogin:(BOOL)isLogin
{
    _isLogin = isLogin;
    
    if(isLogin)
    {
        _lbPhone.hidden = NO;
        self.btnLogin.hidden = YES;
        //self.btnXdollar.hidden = NO;
        //self.btnActivity.hidden = NO;
        
        self.loginModel = _loginModel;
    }
    else
    {
        _lbPhone.hidden = YES;
        self.btnLogin.hidden = NO;
        //self.btnXdollar.hidden = YES;
        //self.btnActivity.hidden = YES;
        
        self.loginModel = _loginModel;
    }
}

- (void)setLoginModel:(LoginModel *)loginModel
{
    _loginModel = loginModel;
    
    if(_isLogin)
    {
        [_imgvHead sd_setImageWithURL:[NSURL URLWithString:loginModel.headImg] placeholderImage:PlaceholderHead];
        _lbPhone.text = loginModel.phone;
        _lbXdollar.text = [NSNumber numberWithFloat:loginModel.xdollarValue.integerValue*0.01].stringValue;
        _lbActivity.text = loginModel.couponActivityCount.stringValue;
    }
    else
    {
        _imgvHead.image = PlaceholderHead;
        
        _lbPhone.text = @"";
        _lbXdollar.text = @"0";
        _lbActivity.text = @"0";
    }
    
}



- (UIButton *)btnSetting
{
    if(_btnSetting==nil)
    {
        _btnSetting = [[UIButton alloc] init];
        [self addSubview:_btnSetting];
        [_btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(44);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(20);
            
        }];
    }
    
    return _btnSetting;
}

- (UIButton *)btnHeadImage
{
    if(_btnHeadImage==nil)
    {
        _btnHeadImage = [[UIButton alloc] init];
        [self addSubview:_btnHeadImage];
        [_btnHeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(90);
            make.left.mas_equalTo(_imgvHead.mas_left).offset(0);
            make.top.mas_equalTo(_imgvHead.mas_top).offset(0);
            
        }];
    }
    
    return _btnHeadImage;
}

- (UIButton *)btnLogin
{
    if(_btnLogin==nil)
    {
        _btnLogin = [[UIButton alloc] init];
        _btnLogin.backgroundColor = Blue_Color;
        _btnLogin.layer.masksToBounds = YES;
        _btnLogin.layer.borderColor = [UIColor whiteColor].CGColor;
        _btnLogin.layer.borderWidth = LINE_WIDTH;
        _btnLogin.layer.cornerRadius = 2;
        [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnLogin.titleLabel.font = Font(12);
        [self addSubview:_btnLogin];
        [_btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(32);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_imgvHead.mas_bottom).offset(6);
            
        }];
    }
    
    return _btnLogin;
}

- (UIButton *)btnXdollar
{
    if(_btnXdollar==nil)
    {
        _btnXdollar = [[UIButton alloc] init];
        [self addSubview:_btnXdollar];
        [_btnXdollar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2-20);
            make.height.mas_equalTo(32);
            make.centerX.mas_equalTo(-MAIN_SCREEN_WIDTH/4);
            make.top.mas_equalTo(_lbPhone.mas_bottom).offset(15);
            
        }];
    }
    
    return _btnXdollar;
}

- (UIButton *)btnActivity
{
    if(_btnActivity==nil)
    {
        _btnActivity = [[UIButton alloc] init];
        [self addSubview:_btnActivity];
        [_btnActivity mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH/2-20);
            make.height.mas_equalTo(32);
            make.centerX.mas_equalTo(MAIN_SCREEN_WIDTH/4);
            make.top.mas_equalTo(_lbPhone.mas_bottom).offset(15);
            
        }];
    }
    
    return _btnActivity;
}



@end
