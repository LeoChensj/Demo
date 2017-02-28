//
//  NetworkOpenDoorViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "NetworkOpenDoorViewController.h"

@implementation NetworkOpenDoorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"网络开门";
    self.headView.imgLeft = @"ic_turn_off";
    self.headView.sizeLeft = CGSizeMake(19, 19);
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

- (void)setupView
{
    _scrollView = [[TouchEventScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    _cardIdView = [[NetworkOpenDoorCardIdView alloc] init];
    [_scrollView addSubview:_cardIdView];
    [_cardIdView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(15);
        
    }];
    
    _verifyCodeButton = [[VerifyCodeButton alloc] init];
    [_cardIdView addSubview:_verifyCodeButton];
    [_verifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(38);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        
    }];
    
    
    _passwordView = [[NetworkOpenDoorPasswordView alloc] init];
    [_scrollView addSubview:_passwordView];
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_cardIdView.mas_bottom).offset(0);
        
    }];
    
    
    _speakerVerifyView = [[SpeakerVerifyView alloc] init];
    [_scrollView addSubview:_speakerVerifyView];
    [_speakerVerifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(_passwordView.mas_bottom).offset(20);
        
    }];
    
    
    _btnOpenDoor = [[BlueEnableButton alloc] init];
    _btnOpenDoor.title = @"远程开门";
    [_scrollView addSubview:_btnOpenDoor];
    [_btnOpenDoor mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_speakerVerifyView.mas_bottom).offset(30);
        
    }];
    
    
    _noticeView = [[NetworkOpenDoorNoticeView alloc] init];
    [_scrollView addSubview:_noticeView];
    [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(_noticeView.myHeight);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_btnOpenDoor.mas_bottom).offset(30);
        
    }];
    
    
    _btnPhone = [[UIButton alloc] init];
    _btnPhone.backgroundColor = Background_Color;
    _btnPhone.layer.masksToBounds = YES;
    _btnPhone.layer.cornerRadius = 3;
    _btnPhone.layer.borderWidth = LINE_WIDTH;
    _btnPhone.layer.borderColor = Blue_Color.CGColor;
    [_btnPhone setTitle:@"拨打客服电话" forState:UIControlStateNormal];
    [_btnPhone setTitleColor:Blue_Color forState:UIControlStateNormal];
    _btnPhone.titleLabel.font = Font(12);
    [_scrollView addSubview:_btnPhone];
    [_btnPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(34);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_noticeView.mas_bottom).offset(30);
        
    }];
    
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_btnPhone.mas_bottom).offset(10);
        
    }];
}

- (void)bindViewModel
{
    RAC(self.viewModel, cardId) = _cardIdView.textField.rac_textSignal;
    RAC(self.viewModel, password) = _passwordView.textField.rac_textSignal;
    
    RAC(_verifyCodeButton, enabled) = self.viewModel.signalCardId;
    RAC(_speakerVerifyView.btnVerify, enabled) = self.viewModel.signalCardId;
    RAC(_btnOpenDoor, enabled) = self.viewModel.signalCardIdPwd;
    
    WS(ws);
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
    
    
    
    [[_btnOpenDoor rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"开门");
        
        [ws.view endEditing:YES];
        
        [[ws.viewModel.commandOpenDoor execute:nil] subscribeNext:^(NSString *x) {
            
            if(x.length)
            {
                [ws.view makeToast:x];
            }
            else
            {
                ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"网络开门成功，门锁发出提示声后即可开门！" cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
                [ws.alertView show];
                
                [ws dismissViewControllerAnimated:YES completion:nil];
            }
            
        }];
        
    }];
    
    
    [[_btnPhone rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        CallPhone([DBManager getInstance].appUITextData.serviceTelephone);
        
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


- (NetworkOpenDoorViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[NetworkOpenDoorViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
