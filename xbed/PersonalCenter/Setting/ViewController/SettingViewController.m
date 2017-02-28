//
//  SettingViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SettingViewController.h"
#import "WebViewController.h"

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"设置";
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
    _scrollView.contentInset = UIEdgeInsetsMake(10, 0, 10+49, 0);
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    _cellAbout = [[NormalTableCell alloc] init];
    _cellAbout.title = @"关于Xbed";
    _cellAbout.haveLine = YES;
    [_scrollView addSubview:_cellAbout];
    [_cellAbout mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        
    }];
    
    _cellAppStore = [[NormalTableCell alloc] init];
    _cellAppStore.title = @"喜欢Xbed，就去鼓励下";
    _cellAppStore.haveLine = NO;
    [_scrollView addSubview:_cellAppStore];
    [_cellAppStore mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_cellAbout.mas_bottom).offset(0);
        
    }];
    
    
    _btnLogout = [[SimpleTableCell alloc] init];
    _btnLogout.title = @"退出账号";
    _btnLogout.haveLine1 = YES;
    _btnLogout.haveLine2 = YES;
    [_scrollView addSubview:_btnLogout];
    [_btnLogout mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_cellAppStore.mas_bottom).offset(20);
        
    }];
    
}

- (void)bindViewModel
{
    RAC(_btnLogout, hidden) = self.viewModel.signalLogoutHidden;
}


- (void)handleEvent
{
    WS(ws);
    
    [[_cellAbout rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.webTitle = @"关于Xbed";
        webVC.url = @"http://about.xbed.com.cn";
        [[RootViewController getInstance] pushViewController:webVC animated:YES];
        
    }];
    
    [[_cellAppStore rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSString *evaluateAppUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", Apple_AppId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:evaluateAppUrl]];
        
    }];
    
    
    [[_btnLogout rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"是否确定退出账号" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" cancelButtonBlock:nil otherButtonBlock:^{
            
            [[ws.viewModel.commandLogout execute:nil] subscribeNext:^(id x) {
                
                [ws back];
                
            }];
            
        }];
        [ws.alertView show];
        
    }];
    
}




- (SettingViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[SettingViewModel alloc] init];
    }
    
    return _viewModel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
