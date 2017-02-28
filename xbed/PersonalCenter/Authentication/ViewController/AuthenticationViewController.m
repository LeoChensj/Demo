//
//  AuthenticationViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "FaceVerificationStep1ViewController.h"
#import "CardVerificationViewController.h"

@implementation AuthenticationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"身份验证";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
    _faceCardView = [[AuthenticationFaceCardView alloc] init];
    [_scrollView addSubview:_faceCardView];
    [_faceCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49*2);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(15);
        
    }];
    
}

- (void)bindViewModel
{
    RAC(self.viewModel, loginModel) = RACObserve([DBManager getInstance], loginModel);
    
    RAC(_faceCardView, loginModel) = RACObserve(self.viewModel, loginModel);
}

- (void)handleEvent
{
    WS(ws);
    
    [[_faceCardView.cellFace rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"人脸识别验证");
        if(ws.viewModel.loginModel.faceRecognition.boolValue)
        {
            ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"你已经人脸验证通过了！" cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
            [ws.alertView show];
        }
        else
        {
            FaceVerificationViewModel *viewModel = [[FaceVerificationViewModel alloc] init];
            viewModel.loginModel = [ws.viewModel.loginModel copy];
            PushVCWithVM(FaceVerificationStep1ViewController, viewModel);
        }
    }];
    
    [[_faceCardView.cellCard rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"身份证验证");
        
        if(ws.viewModel.loginModel.state.integerValue==2)
        {
            ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"你已经身份证验证通过了！" cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
            [ws.alertView show];
        }
        else
        {
            PushVC(CardVerificationViewController, YES);
        }
        
    }];
    
}



- (AuthenticationViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[AuthenticationViewModel alloc] init];
    }
    
    return _viewModel;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
