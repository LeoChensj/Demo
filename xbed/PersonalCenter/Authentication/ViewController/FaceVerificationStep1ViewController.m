//
//  FaceVerificationStep1ViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "FaceVerificationStep1ViewController.h"
#import "CameraViewController.h"

@implementation FaceVerificationStep1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([DBManager getInstance].loginModel.faceRecognition.boolValue)
    {
        [self back];
    }
}


- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"人脸识别验证";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _inputView = [[FaceVerificationInputView alloc] init];
    [self.view addSubview:_inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49*2);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64+15);
        
    }];
    _inputView.loginModel = self.viewModel.loginModel;
    
    
    
    
    _btnNext = [[BlueEnableButton alloc] init];
    _btnNext.title = @"下一步";
    [self.view addSubview:_btnNext];
    [_btnNext mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_inputView.mas_bottom).offset(40);
        
    }];
    
    
    _remindView = [[AuthenticationRemindLabel alloc] init];
    [self.view addSubview:_remindView];
    [_remindView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(_remindView.myHeight);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_btnNext.mas_bottom).offset(30);
        
    }];
    
}

- (void)bindViewModel
{
    RAC(self.viewModel.loginModel, name) = _inputView.cellName.tfValue.rac_textSignal;
    RAC(self.viewModel.loginModel, idNo) = _inputView.cellCardId.tfValue.rac_textSignal;
    
    RAC(_btnNext, enabled) = self.viewModel.signalNextStep;
}

- (void)handleEvent
{
    WS(ws);
    [[_btnNext rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"下一步");
        
        [ws.view endEditing:YES];
        
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus==AVAuthorizationStatusAuthorized || authStatus==AVAuthorizationStatusNotDetermined)//允许访问相机或第一次未知
        {
            [[ws.viewModel.commandCanFaceVerification execute:nil] subscribeNext:^(NSString *x) {
                
                if(x && x.length)
                {
                    [ws.view makeToast:x];
                }
                else
                {
                    if(ws.viewModel.canFaceVerify)
                    {
                        FaceVerificationViewModel *viewModel = ws.viewModel;
                        PushVCWithVM(CameraViewController, viewModel);
                    }
                    else
                    {
                        ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"你的验证次数已经达到上限，请选择上传身份证照片进行身份验证" cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:^{
                            
                            CardVerificationViewController *vc = [[CardVerificationViewController alloc] init];
                            
                            NSMutableArray *tempVC = [NSMutableArray arrayWithArray:[RootViewController getInstance].viewControllers];
                            [tempVC removeLastObject];
                            [tempVC addObject:vc];
                            
                            [[RootViewController getInstance] setViewControllers:tempVC animated:YES];
                            
                        } otherButtonBlock:nil];
                        [ws.alertView show];
                    }
                }
                
            }];
        }
        else//不允许
        {
            ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"请在设置-隐私-相机开启Xbed访问相机权限" cancelButtonTitle:@"确定" otherButtonTitle:nil cancelButtonBlock:^{
                
                if(More_iOS8)
                {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url])
                    {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
                
            } otherButtonBlock:nil];
            [ws.alertView show];
        }
        
    }];
}




- (FaceVerificationViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[FaceVerificationViewModel alloc] init];
    }
    
    return _viewModel;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
