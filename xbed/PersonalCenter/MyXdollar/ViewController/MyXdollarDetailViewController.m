//
//  MyXdollarDetailViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyXdollarDetailViewController.h"

@implementation MyXdollarDetailViewController

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
    self.headView.title = @"Xdollar明细";
    self.headView.titleColor = [UIColor whiteColor];
    self.headView.imgLeft = @"ic_back_slide";
    self.headView.haveLine = NO;
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _xdollarDetailListView = [[XdollarDetailListView alloc] init];
    [self.view addSubview:_xdollarDetailListView];
    [_xdollarDetailListView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
}

- (void)bindViewModel
{
    RAC(_xdollarDetailListView, dataArray) = RACObserve(self.viewModel, xdollarListData);
}

- (void)handleEvent
{
    WS(ws);
    
    if(self.viewModel.xdollarListData.count==self.viewModel.totalElements.integerValue)
    {
        ws.xdollarDetailListView.footer.hidden = YES;
    }
    
    
    [_xdollarDetailListView addXdollarDetailListViewLoadmoreBlock:^(XdollarDetailListView *view) {
        
        [[ws.viewModel.commandGetMoreData execute:nil] subscribeNext:^(NSString *x) {
            
            if(x.length)
            {
                [ws.view makeToast:x];
            }
            
            [view.mj_footer endRefreshing];
            
            if(ws.viewModel.xdollarListData.count==ws.viewModel.totalElements.integerValue)
            {
                view.footer.hidden = YES;
            }
            
        }];
        
    }];
    
    
    
    
}






- (MyXdollarDetailViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[MyXdollarDetailViewModel alloc] init];
    }
    
    return _viewModel;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
