//
//  NetworkOpenDoorViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "NetworkOpenDoorViewModel.h"
#import "TouchEventScrollView.h"
#import "NetworkOpenDoorCardIdView.h"
#import "VerifyCodeButton.h"
#import "NetworkOpenDoorPasswordView.h"
#import "SpeakerVerifyView.h"
#import "BlueEnableButton.h"
#import "NetworkOpenDoorNoticeView.h"
#import "PictureVerifyCodeView.h"

@interface NetworkOpenDoorViewController : XbedViewController

@property (nonatomic, strong)NetworkOpenDoorViewModel *viewModel;

@property (nonatomic, strong, readonly)TouchEventScrollView *scrollView;
@property (nonatomic, strong, readonly)NetworkOpenDoorCardIdView *cardIdView;
@property (nonatomic, strong, readonly)VerifyCodeButton *verifyCodeButton;
@property (nonatomic, strong, readonly)NetworkOpenDoorPasswordView *passwordView;
@property (nonatomic, strong, readonly)SpeakerVerifyView *speakerVerifyView;
@property (nonatomic, strong, readonly)BlueEnableButton *btnOpenDoor;
@property (nonatomic, strong, readonly)NetworkOpenDoorNoticeView *noticeView;
@property (nonatomic, strong, readonly)UIButton *btnPhone;
@property (nonatomic, strong)STAlertView *alertView;

@property (nonatomic, strong)PictureVerifyCodeView *picCodeView;

@end
