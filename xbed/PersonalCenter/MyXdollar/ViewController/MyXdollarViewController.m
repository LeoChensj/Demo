//
//  MyXdollarViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyXdollarViewController.h"
#import "WebViewController.h"
#import "MyXdollarDetailViewController.h"

@implementation MyXdollarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.backgroundColor = Blue_Color;
    self.headView.imgLeft = @"ic_back_slide";
    self.headView.rightColor = [UIColor whiteColor];
    self.headView.haveLine = NO;
    [self.view addSubview:self.headView];
    
    WS(ws);
    
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
    
    
    [[self.headView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"明细");
        
        MyXdollarDetailViewModel *viewModel = [[MyXdollarDetailViewModel alloc] init];
        viewModel.page = ws.viewModel.page;
        viewModel.size = ws.viewModel.size;
        viewModel.xdollarListData = ws.viewModel.xdollarListData;
        viewModel.totalElements = ws.viewModel.totalElements;
        PushVCWithVM(MyXdollarDetailViewController, viewModel);
        
    }];
}

- (void)setupView
{
    _baseInfoView = [[MyXdollarBaseInfoView alloc] init];
    [self.view addSubview:_baseInfoView];
    [_baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(186);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
    _rulesView = [[MyXdollarRulesView alloc] init];
    [self.view addSubview:_rulesView];
    [_rulesView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(250);
         
    }];
    
    
    _btnDetail = [[UIButton alloc] init];
    _btnDetail.backgroundColor = Background_Color;
    _btnDetail.layer.masksToBounds = YES;
    _btnDetail.layer.cornerRadius = 2;
    _btnDetail.layer.borderColor = Blue_Color.CGColor;
    _btnDetail.layer.borderWidth = LINE_WIDTH;
    [_btnDetail setTitle:@"查看详细规则" forState:UIControlStateNormal];
    [_btnDetail setTitleColor:Blue_Color forState:UIControlStateNormal];
    _btnDetail.titleLabel.font = Font(12);
    [self.view addSubview:_btnDetail];
    [_btnDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(34);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_rulesView.mas_bottom).offset(60);
        
    }];
    
}

- (void)bindViewModel
{
    RAC(_baseInfoView, xdollar) = RACObserve(self.viewModel, xdollar);
    RAC(_rulesView, rules) = RACObserve(self.viewModel, rules);
    
    WS(ws);
    [RACObserve(self.viewModel, xdollarListData) subscribeNext:^(NSArray <XdollarModel *>*x) {
        
        if(x && x.count)
        {
            ws.headView.txtRight = @"明细";
            ws.headView.btnRight.enabled = YES;
        }
        else
        {
            ws.headView.txtRight = nil;
            ws.headView.btnRight.enabled = NO;
        }
        
    }];
}

- (void)handleEvent
{
    WS(ws);
    
    [[self.viewModel.commandGetXdollarData execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [ws.view makeToast:x];
        }
        
    }];
    
    [[_btnDetail rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"查看详细规则");
        
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.url = [NSString stringWithFormat:@"%@/xdollar", URL_Web];
        [[RootViewController getInstance] pushViewController:webVC animated:YES];
        
    }];
    
    
}


- (MyXdollarViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[MyXdollarViewModel alloc] init];
    }
    
    return _viewModel;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
