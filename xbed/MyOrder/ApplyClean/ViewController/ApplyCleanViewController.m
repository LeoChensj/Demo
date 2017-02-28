//
//  ApplyCleanViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ApplyCleanViewController.h"

@implementation ApplyCleanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"申请在住清洁";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _timeSelectView = [[CleanTimeSelectView alloc] init];
    [self.view addSubview:_timeSelectView];
    [_timeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
    
    _btnApply = [[BlueButton alloc] init];
    _btnApply.title = @"提交申请";
    [self.view addSubview:_btnApply];
    [_btnApply mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.bottom.mas_equalTo(0);
        
    }];
    
}

- (void)bindViewModel
{
    RAC(_timeSelectView, todayDataArray) = RACObserve(self.viewModel, todayData);
    RAC(_timeSelectView, tomorrowDataArray) = RACObserve(self.viewModel, tomorrowData);
    RAC(self.viewModel, selectTime) = RACObserve(_timeSelectView, selectTime);
    RAC(_btnApply, enabled) = self.viewModel.signalSelectTime;
}

- (void)handleEvent
{
    WS(ws);
    
    [[_btnApply rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"申请清洁");
        
        [[ws.viewModel.commandApplyClean execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)
            {
                [ws.view makeToast:x];
            }
            else
            {
                [ws.view makeToast:@"申请成功"];
                [ws back];
            }
            
        }];
        
    }];
}







- (ApplyCleanViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[ApplyCleanViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
