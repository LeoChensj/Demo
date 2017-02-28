//
//  FeedbackViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "FeedbackViewController.h"

@implementation FeedbackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"意见反馈";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _inputView = [[FeedbackInputView alloc] init];
    [self.view addSubview:_inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_WIDTH*2/3);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64+15);
        
    }];
    
    
    _btnSubmit = [[BlueEnableButton alloc] init];
    _btnSubmit.title = @"提交";
    [self.view addSubview:_btnSubmit];
    [_btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_inputView.mas_bottom).offset(40);
        
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
    [self.view addSubview:_btnPhone];
    [_btnPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(34);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_btnSubmit.mas_bottom).offset(40);
        
    }];
    
}

- (void)bindViewModel
{
    RAC(self.viewModel, opinion) = RACObserve(_inputView, content);
    RAC(_btnSubmit, enabled) = self.viewModel.signalOpinion;
}

- (void)handleEvent
{
    WS(ws);
    
    [[_btnSubmit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"提交");
        
        [[ws.viewModel.commandSubmit execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)
            {
                [ws.view makeToast:x];
            }
            else
            {
                [[UIApplication sharedApplication].keyWindow makeToast:@"提交成功"];
                [ws back];
            }
            
        }];
        
    }];
    
    [[_btnPhone rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        CallPhone([DBManager getInstance].appUITextData.serviceTelephone);
        
    }];
    
}




- (FeedbackViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[FeedbackViewModel alloc] init];
    }
    
    return _viewModel;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
