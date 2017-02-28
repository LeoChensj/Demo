//
//  PersonalCenterViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/7/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "WebViewController.h"
#import "LoginViewController.h"
#import "MyXdollarViewController.h"
#import "MyCouponActivityViewController.h"
#import "PhotoAlbumUtil.h"
#import "WebViewController.h"
#import "AuthenticationViewController.h"
#import "CardVerificationViewController.h"
#import "InvoiceSelectOrderViewController.h"
#import "FeedbackViewController.h"
#import "SettingViewController.h"

@implementation PersonalCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([DBManager getInstance].isLogin)
    {
        [self.viewModel.commandRefreshLoginData execute:nil];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupView
{
    _baseInfoView = [[PersonalCenterBaseInfoView alloc] init];
    [self.view addSubview:_baseInfoView];
    [_baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(250);
        make.left.top.mas_equalTo(0);
        
    }];
    
    _tableView = [[PersonalCenterTableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-250);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_baseInfoView.mas_bottom).offset(0);
        
    }];
    
    
}

- (void)bindViewModel
{
    RAC(self.viewModel, isLogin) = RACObserve([DBManager getInstance], isLogin);
    RAC(self.viewModel, loginModel) = RACObserve([DBManager getInstance], loginModel);
    
    RAC(_baseInfoView, isLogin) = RACObserve(self.viewModel, isLogin);
    RAC(_baseInfoView, loginModel) = RACObserve(self.viewModel, loginModel);
    RAC(_tableView, loginModel) = RACObserve(self.viewModel, loginModel);
}

- (void)handleEvent
{
    WS(ws);
    @weakify(self);
    
    [[_baseInfoView.btnSetting rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"设置");
        
        PushVC(SettingViewController, YES);
        
    }];
    
    
    [[_baseInfoView.btnLogin rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self);
        PresentVC(LoginViewController);
        
    }];
    
    [[_baseInfoView.btnHeadImage rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self);
        if(ws.viewModel.isLogin)
        {
            PhotoAlbumUtil *photoAlbumUtil = [PhotoAlbumUtil getInstance];
            photoAlbumUtil.title = @"上传头像";
            photoAlbumUtil.allowsEditing = YES;
            [photoAlbumUtil selectTakePhotoOrAlbum];
            [photoAlbumUtil addPhotoAlbumUtilBlock:^(UIImage * _Nullable image) {
                
                ws.viewModel.headData = [PhotoAlbumUtil dataFromImage:[PhotoAlbumUtil imageWithImage:image scaledToSize:CGSizeMake(180, 180)]];
                [[ws.viewModel.commandUpLoadHead execute:nil] subscribeNext:^(NSString *x) {
                    
                    if(x && x.length)
                    {
                        [[UIApplication sharedApplication].keyWindow makeToast:x];
                    }
                    
                }];
                
            }];
        }
        else
        {
            PresentVC(LoginViewController);
        }
        
    }];
    
    [[_baseInfoView.btnXdollar rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"Xdollar");
        
        @strongify(self);
        if(ws.viewModel.isLogin)
        {
            MyXdollarViewModel *viewModel = [[MyXdollarViewModel alloc] init];
            viewModel.xdollar = ws.viewModel.loginModel.xdollarValue;
            PushVCWithVM(MyXdollarViewController, viewModel);
        }
        else
        {
            PresentVC(LoginViewController);
        }
        
    }];
    
    [[_baseInfoView.btnActivity rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"优惠活动");
        
        @strongify(self);
        if(ws.viewModel.isLogin)
        {
            PushVC(MyCouponActivityViewController, YES);
        }
        else
        {
            PresentVC(LoginViewController);
        }
        
    }];
    
    
    [[_tableView.cellIdentity rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"身份验证");
        
        @strongify(self);
        if(ws.viewModel.isLogin)
        {
            AuthenticationViewModel *viewModel = [[AuthenticationViewModel alloc] init];
            viewModel.loginModel = ws.viewModel.loginModel;
            PushVCWithVM(AuthenticationViewController, viewModel);
            
            //PushVC(CardVerificationViewController, YES);
        }
        else
        {
            PresentVC(LoginViewController);
        }
        
    }];
    
    [[_tableView.cellInvoice rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"发票");
        
        @strongify(self);
        if(ws.viewModel.isLogin)
        {
            PushVC(InvoiceSelectOrderViewController, YES);
        }
        else
        {
            PresentVC(LoginViewController);
        }
        
    }];
    
    [[_tableView.cellProblem rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"常见问题");
        
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.url = [NSString stringWithFormat:@"%@/fqa/ios", URL_Web];
        [[RootViewController getInstance] pushViewController:webVC animated:YES];
        
    }];
    
    [[_tableView.cellOpinion rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"意见反馈");
        
        @strongify(self);
        if(ws.viewModel.isLogin)
        {
            PushVC(FeedbackViewController, YES);
        }
        else
        {
            PresentVC(LoginViewController);
        }
    }];
    
    [[_tableView.cellPhone rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"客服电话");
        
        CallPhone([DBManager getInstance].appUITextData.serviceTelephone);
        
    }];
    
}





#pragma mark - Get
- (PersonalCenterViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[PersonalCenterViewModel alloc] init];
    }
    
    return _viewModel;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}


@end
