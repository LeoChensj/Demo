//
//  OrderPriceDetailViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/9/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderPriceDetailViewController.h"

@implementation OrderPriceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.imgLeft = @"ic_turn_off";
    self.headView.sizeLeft = CGSizeMake(19, 19);
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

- (void)setupView
{
    _listView = [[OrderPriceDetailListView alloc] initWithRentType:self.viewModel.rentType];
    [self.view addSubview:_listView];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
}

- (void)bindViewModel
{
    RAC(_listView, payInfo) = RACObserve(self.viewModel, payInfo);
    RAC(_listView, actualPrice) = RACObserve(self.viewModel, actualPrice);
}

- (void)handleEvent
{
    
}




- (OrderPriceDetailViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[OrderPriceDetailViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
