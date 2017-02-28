//
//  HomeMainViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/7/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomeMainViewController.h"
#import "SearchViewController.h"
#import "ScreenRoomViewController.h"

@implementation HomeMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_banner startTimer];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_banner stopTimer];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT);
        make.left.top.mas_equalTo(0);
        
    }];
    
    
    _refresh = [[HomeMainRefresh alloc] initWithScrollView:_scrollView];
    
    
    _banner = [[HomeMainBanner alloc] init];
    [_scrollView addSubview:_banner];
    
    
    _navgationView = [[HomeMainNavigationView alloc] init];
    [self.view addSubview:_navgationView];
    [_navgationView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(64);
        make.left.top.mas_equalTo(0);
        
    }];
    
    
    //广告位
    _advertView1 = [[HomeMainAdvertView1 alloc] init];
    [_scrollView addSubview:_advertView1];
    [_advertView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_banner.mas_bottom).offset(10);
        
    }];
    
    
    
    //热门目的地 headView
    _cityHeadView = [[HomeMainCityHeadView alloc] init];
    [_scrollView addSubview:_cityHeadView];
    [_cityHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_advertView1.mas_bottom).offset(0);
        
    }];

    
    
    _cityTableView = [[HomeMainCityTableView alloc] init];
    [_scrollView addSubview:_cityTableView];
    [_cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(HomeMainCityRowHeight);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_cityHeadView.mas_bottom).offset(10);
        
    }];

    
    
    //底部广告
    _advertView2 = [[HomeMainAdvertView2 alloc] init];
    [_scrollView addSubview:_advertView2];
    [_advertView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
        make.height.mas_equalTo(100);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_cityTableView.mas_bottom).offset(10);
        
    }];
    
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_advertView2.mas_bottom).offset(TABBAR_HEIGHT);//对于scrollView来说，bottom时设置contentSize
        
    }];
    
}

- (void)bindViewModel
{
    RAC(self.banner, dataArray) = RACObserve(self.viewModel, bannerData);
    RAC(self.advertView1, dataArray) = RACObserve(self.viewModel, adData1);
    RAC(self.cityTableView, dataArray) = RACObserve(self.viewModel, cityData);
    RAC(self.advertView2, dataArray) = RACObserve(self.viewModel, adData2);
    RAC(_cityHeadView, hidden) = self.viewModel.signalCityData;
}

- (void)handleEvent
{
    WS(ws);
    
    [RACObserve(_scrollView, contentOffset) subscribeNext:^(id x) {
        
        CGFloat contentOffsetY = ws.scrollView.contentOffset.y;
        
        if(contentOffsetY<=0)
        {
            _navgationView.backgroundColor = [Blue_Color colorWithAlphaComponent:0];
            
            if(contentOffsetY>-100)
                _navgationView.searchBar.alpha = (contentOffsetY+100)/100;
            else
                _navgationView.searchBar.alpha = 0;
        }
        else
        {
            _navgationView.searchBar.alpha = 1;
            
            if(contentOffsetY<100)
                _navgationView.backgroundColor = [Blue_Color colorWithAlphaComponent:(1-(100-contentOffsetY)/100)*0.9];
            else
                _navgationView.backgroundColor = [Blue_Color colorWithAlphaComponent:0.9];
            
            
        }
        
    }];
    
    
    
    
    
    [[self.viewModel.commandGetData execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [[UIApplication sharedApplication].keyWindow makeToast:x];
        }
        
    }];
    
    
    [[_navgationView.searchBar rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"搜索");
        
        PushVC(SearchViewController, NO);
        
    }];
    
    [_refresh addHomeMainRefreshDataBlock:^(HomeMainRefresh *refresh) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[ws.viewModel.commandGetData execute:nil] subscribeNext:^(NSString *x) {
                
                [refresh finishingLoading];
                
                if(x && x.length)
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:x];
                }
                
            }];
            
        });
        
    }];
    
    
    [_cityTableView addHomeMainCityTableViewDidSelectRowBlock:^(HomeMainCityTableView *tableView, HomeMainModel *model, NSIndexPath *indexPath) {
        
        ScreenRoomViewModel *viewModel = [[ScreenRoomViewModel alloc] init];
        
        NSString *city;
        if([[model.name substringWithRange:NSMakeRange(model.name.length-1, 1)] isEqualToString:@"市"])
        {
            city = model.name;
        }
        else
        {
            city = [NSString stringWithFormat:@"%@市", model.name];
        }
        
        viewModel.city = city;
        PushVCWithVM(ScreenRoomViewController, viewModel);
        
    }];
    
}





- (HomeMainViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[HomeMainViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}



@end
