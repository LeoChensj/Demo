//
//  LoginViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LoginViewController.h"


@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)config
{
    [super config];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    @weakify(self);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self);
        DismissVC(YES);
        
    }];
}

- (void)setupView
{
    UIImageView *imgvLogin = [[UIImageView alloc] init];
    imgvLogin.image = [UIImage imageNamed:@"pic_login_logo"];
    [self.view addSubview:imgvLogin];
    [imgvLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(149);
        make.height.mas_equalTo(61);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(64+45);
        
    }];
    
    
    _lbInfo = [[UILabel alloc] init];
    //_lbInfo.text = @"首次登录送100元大礼包";
    _lbInfo.textColor = Blue_Color;
    _lbInfo.textAlignment = NSTextAlignmentCenter;
    _lbInfo.font = Font(13);
    [self.view addSubview:_lbInfo];
    [_lbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(13);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(imgvLogin.mas_bottom).offset(35);
        
    }];
    
    
    _phoneView = [[LoginPhoneView alloc] init];
    [self.view addSubview:_phoneView];
    [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
        make.height.mas_equalTo(49);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_lbInfo.mas_bottom).offset(15);
        
    }];
    
    _verifyCodeButton = [[VerifyCodeButton alloc] init];
    [_phoneView addSubview:_verifyCodeButton];
    [_verifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(38);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(0);
        
    }];
    
    
    
    _passwordView = [[LoginPasswordView alloc] init];
    [self.view addSubview:_passwordView];
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
        make.height.mas_equalTo(49);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_phoneView.mas_bottom).offset(2);
        
    }];
    
    
    _speakerVerifyView = [[SpeakerVerifyView alloc] init];
    [self.view addSubview:_speakerVerifyView];
    [_speakerVerifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_passwordView.mas_bottom).offset(20);
        
    }];
    
    
    
    _loginButton = [[LoginButton alloc] init];
    [self.view addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_speakerVerifyView.mas_bottom).offset(30);
        
    }];
    
    
}

- (void)bindViewModel
{
    WS(ws);
    
    RAC(_lbInfo, text) = RACObserve([DBManager getInstance], appUITextData.loginPage);
    
    RAC(self.viewModel, phone) = _phoneView.textField.rac_textSignal;
    RAC(self.viewModel, password) = _passwordView.textField.rac_textSignal;
    
    RAC(_verifyCodeButton, enabled) = self.viewModel.signalPhone;
    //RAC(_speakerVerifyView.btnVerify, enabled) = self.viewModel.signalPhone;
    RAC(_loginButton, enabled) = self.viewModel.signalPhonePwd;
    
    
    
    [RACObserve(self.viewModel, getCodeFlag1) subscribeNext:^(NSNumber *x) {
        
        if(x)
        {
            if(x.integerValue==1)//不可点
            {
                ws.verifyCodeButton.enabled = NO;
                ws.verifyCodeButton.states = NO;
            }
            else if(x.integerValue==2)//倒计时
            {
                ws.verifyCodeButton.enabled = NO;
                ws.verifyCodeButton.states = YES;
            }
            else if(x.integerValue==3)//可点
            {
                ws.verifyCodeButton.enabled = YES;
                ws.verifyCodeButton.states = NO;
            }
        }
        
    }];
    
    [RACObserve(self.viewModel, getCodeFlag2) subscribeNext:^(NSNumber *x) {
        
        if(x)
        {
            if(x.integerValue==1)//不可点
            {
                ws.speakerVerifyView.btnVerify.enabled = NO;
                ws.speakerVerifyView.states = NO;
            }
            else if(x.integerValue==2)//倒计时
            {
                ws.speakerVerifyView.btnVerify.enabled = NO;
                ws.speakerVerifyView.states = YES;
            }
            else if(x.integerValue==3)//可点
            {
                ws.speakerVerifyView.btnVerify.enabled = YES;
                ws.speakerVerifyView.states = NO;
            }
        }
        
    }];
}

- (void)handleEvent
{
    WS(ws);
    [[_verifyCodeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"验证码");
        
        [ws.view endEditing:YES];
        
        ws.viewModel.isText = @"true";
        [[ws.viewModel.commandGetVerifyCode execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)
            {
                if([x isEqualToString:@"imageCode"])//图形验证码
                {
                    self.picCodeView.base64 = ws.viewModel.codeBase64;
                }
                else
                {
                    [ws.view makeToast:x];
                }
            }
            else
            {
                [ws.view makeToast:@"验证码已发送，请耐心等待"];
            }
            
        }];
        
    }];
    
    [[_speakerVerifyView.btnVerify rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"语音验证");
        
        [ws.view endEditing:YES];
        
        ws.viewModel.isText = @"false";
        [[ws.viewModel.commandGetVerifyCode execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)
            {
                if([x isEqualToString:@"imageCode"])//图形验证码
                {
                    self.picCodeView.base64 = ws.viewModel.codeBase64;
                }
                else
                {
                    [ws.view makeToast:x];
                }
            }
            else
            {
                [ws.view makeToast:@"请耐心等待，稍后会有语音验证码来电"];
            }
            
        }];
        
    }];
    
    [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"登录");
        
        [ws.view endEditing:YES];
        
        [[ws.viewModel.commandLogin execute:nil] subscribeNext:^(NSString *x) {
            
            if(x.length)
            {
                [ws.view makeToast:x];
            }
            else
            {
                [ws dismissViewControllerAnimated:YES completion:nil];
            }
            
        }];
        
    }];
}





- (PictureVerifyCodeView *)picCodeView
{
    if(_picCodeView==nil || _picCodeView.flag==NO)
    {
        _picCodeView = [[PictureVerifyCodeView alloc] init];
        [self.view addSubview:_picCodeView];
        
        WS(ws);
        [[_picCodeView.btnConfirm rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws.view endEditing:YES];
            
            [[ws.viewModel.commandImgVerify execute:ws.picCodeView.tfCode.text] subscribeNext:^(NSString *x) {
                
                if(x && x.length)
                {
                    [ws.view makeToast:x];
                }
                else
                {
                    [ws.picCodeView close];
                }
                
            }];
            
        }];
        
        [[_picCodeView.btnChange rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [[ws.viewModel.commandGetImgVerifyCode execute:nil] subscribeNext:^(NSString *x) {
                
                if(x && x.length)
                {
                    [ws.view makeToast:x];
                }
                else
                {
                    ws.picCodeView.base64 = ws.viewModel.codeBase64;
                }
                
            }];
            
        }];
        
    }
    
    return _picCodeView;
}


-(LoginViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[LoginViewModel alloc] init];
    }
    
    return _viewModel;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
