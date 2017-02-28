//
//  MapRoomViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/7/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MapRoomViewController.h"

@implementation MapRoomViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    _mapRoomHeadView = [[ScreenRoomHeadView alloc] init];
    _mapRoomHeadView.title = @"广州";
    _mapRoomHeadView.imgLeft = @"ic_back";
    _mapRoomHeadView.imgRight = @"ic_room_list";
    [self.view addSubview:_mapRoomHeadView];
    
    WS(ws);
    [[_mapRoomHeadView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
    
    [[_mapRoomHeadView.btnTitle rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"下拉选城市");
        
    }];
    
    [[_mapRoomHeadView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"房间列表");
        
    }];
}

- (void)setupView
{
    _mapRoomView = [[MapRoomView alloc] init];
    [self.view addSubview:_mapRoomView];

}

- (void)bindViewModel
{
    
}

- (void)handleEvent
{
    
}






- (MapRoomViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[MapRoomViewModel alloc] init];
    }
    
    return _viewModel;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}



@end
