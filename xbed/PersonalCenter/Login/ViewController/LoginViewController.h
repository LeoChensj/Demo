//
//  LoginViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "LoginViewModel.h"
#import "LoginPhoneView.h"
#import "VerifyCodeButton.h"
#import "LoginPasswordView.h"
#import "SpeakerVerifyView.h"
#import "LoginButton.h"
#import "PictureVerifyCodeView.h"

@interface LoginViewController : XbedViewController

@property (nonatomic, strong, readonly)UILabel *lbInfo;
@property (nonatomic, strong, readonly)LoginPhoneView *phoneView;
@property (nonatomic, strong, readonly)VerifyCodeButton *verifyCodeButton;
@property (nonatomic, strong, readonly)LoginPasswordView *passwordView;
@property (nonatomic, strong, readonly)SpeakerVerifyView *speakerVerifyView;
@property (nonatomic, strong, readonly)LoginButton *loginButton;

@property (nonatomic, strong)PictureVerifyCodeView *picCodeView;

@property (nonatomic, strong)LoginViewModel *viewModel;

@end
