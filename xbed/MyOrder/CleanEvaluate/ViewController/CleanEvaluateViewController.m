//
//  RoomEvaluateViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/10/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CleanEvaluateViewController.h"

@implementation CleanEvaluateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"清洁评价";
    self.headView.imgLeft = @"ic_back";
    self.headView.txtRight = @"提交";
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _scrollView = [[TouchEventScrollView alloc] init];
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
    _baseInfoView = [[CleanEvaluateBaseInfoView alloc] init];
    [_scrollView addSubview:_baseInfoView];
    [_baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(123);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        
    }];
    
    
    
    _starView = [[CleanEvaluateStarView alloc] init];
    [_scrollView addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(92+30);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_baseInfoView.mas_bottom).offset(0);
        
    }];
    
    
    
    
    _inputView = [[EvaluateInputView alloc] init];
    [_scrollView addSubview:_inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(133);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_starView.mas_bottom).offset(10);
        
    }];
    
    _evaluatePhotoView = [[EvaluatePhotoView alloc] initWithViewController:self];
    [_scrollView addSubview:_evaluatePhotoView];
    [_evaluatePhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(189);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_inputView.mas_bottom).offset(10);
        
    }];
    
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_evaluatePhotoView.mas_bottom).offset(10);
        
    }];
    
}

- (void)bindViewModel
{
    RAC(_baseInfoView, head) = RACObserve(self.viewModel, cleanEvaluationData.head);
    RAC(_baseInfoView, name) = RACObserve(self.viewModel, cleanEvaluationData.name);
    RAC(_baseInfoView, score) = RACObserve(self.viewModel, cleanEvaluationData.score);
    RAC(_starView, cleanStarTerm) = RACObserve(self.viewModel, cleanEvaluationData.cleanStarTerm);
    RAC(self.viewModel, starId) = RACObserve(_starView, starId);
    RAC(self.viewModel, termIdList) = RACObserve(_starView, selectTags);
    RAC(self.viewModel, content) = RACObserve(_inputView, content);
    RAC(self.viewModel, imageDatas) = RACObserve(_evaluatePhotoView, datas);
    RAC(self.headView.btnRight, enabled) = self.viewModel.signalSubmit;
}

- (void)handleEvent
{
    WS(ws);
    
    [[self.headView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"提交");
        
        ws.headView.btnRight.enabled = NO;
        
        [[ws.viewModel.commandSubmit execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)//上传失败
            {
                ws.headView.btnRight.enabled = YES;
                
                [ws.view makeToast:x];
            }
            else//上传成功
            {
                [[UIApplication sharedApplication].keyWindow makeToast:@"评论成功"];
                [ws back];
            }
            
        }];
        
    }];
    
}






- (CleanEvaluateViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[CleanEvaluateViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
