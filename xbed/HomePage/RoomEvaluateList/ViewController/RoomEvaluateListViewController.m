//
//  RoomEvaluateListViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluateListViewController.h"

@implementation RoomEvaluateListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.imgLeft = @"ic_back";
    self.headView.title = @"全部评价";
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _scrollView = [[LoadmoreScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
    _scoreView = [[RoomEvaluateListScoreView alloc] init];
    [_scrollView addSubview:_scoreView];
    [_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(143);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        
    }];
    
    
    _listView = [[RoomEvaluateListView alloc] init];
    [_scrollView addSubview:_listView];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_scoreView.mas_bottom).offset(0);
        
    }];
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_listView.mas_bottom).offset(0);
        
    }];
    
}

- (void)bindViewModel
{
    RAC(_scoreView, score) = RACObserve(self.viewModel, score);
    RAC(_scoreView, evaluateNumber) = RACObserve(self.viewModel, evaluateNumber);
    RAC(_scoreView, roomScore) = RACObserve(self.viewModel, roomScore);
    RAC(_scoreView, cleanScore) = RACObserve(self.viewModel, cleanScore);
    RAC(_listView, dataArray) = RACObserve(self.viewModel, evaluateData);
}

- (void)handleEvent
{
    WS(ws);
    
    [[self.viewModel.commendGetData execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [ws.view makeToast:x];
        }
        else
        {
            if(ws.viewModel.evaluateData.count>=ws.viewModel.totalElements.integerValue)
            {
                ws.scrollView.footer.hidden = YES;
            }
            else
            {
                ws.scrollView.footer.hidden = NO;
            }
        }
        
    }];
    
    
    [_scrollView addLoadmoreScrollViewBlock:^(MJRefreshAutoStateFooter *footer) {
        
        [[ws.viewModel.commendGetMoreData execute:nil] subscribeNext:^(NSString *x) {
            
            [footer endRefreshing];
            
            if(ws.viewModel.evaluateData.count>=ws.viewModel.totalElements.integerValue)
            {
                ws.scrollView.footer.hidden = YES;
            }
            else
            {
                ws.scrollView.footer.hidden = NO;
            }
            
        }];
        
    }];
    
    
}







- (RoomEvaluateListViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[RoomEvaluateListViewModel alloc] init];
    }
    
    return _viewModel;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}


@end
