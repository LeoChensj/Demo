//
//  ScreenPositionViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/7/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenPositionViewController.h"


@implementation ScreenPositionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.imgLeft = @"ic_turn_off";
    self.headView.sizeLeft = CGSizeMake(19, 19);
    self.headView.txtRight = @"清空";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [[self.headView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        ws.positionSelectView.model1 = ws.viewModel.position1 = nil;
        ws.positionSelectView.model2 = ws.viewModel.position2 = nil;
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

- (void)setupView
{
    _positionSelectView = [[PositionSelectView alloc] init];
    [self.view addSubview:_positionSelectView];
    [_positionSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    _positionSelectView.dataArray = _viewModel.positionTags;
    _positionSelectView.model1 = _viewModel.position1;
    _positionSelectView.model2 = _viewModel.position2;
    
    WS(ws);
    [_positionSelectView addPositionSelectViewCompleteBlock:^(ScreenRoomTagModel *model1, ScreenRoomTagModel *model2) {
        
        ws.viewModel.position1 = model1;
        ws.viewModel.position2 = model2;
        
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    }];
}








@end
