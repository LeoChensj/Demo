//
//  RubbishHomePageViewController.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RubbishHomePageViewController.h"
#import "LocateUtil.h"
#import "HomePageCityPickerView.h"
#import "HomePageCalendarViewController.h"
#import "SearchViewController.h"
#import "ScreenRoomViewController.h"

@implementation RubbishHomePageViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_banner startTimer];
    
    if(self.viewModel.bannerData.count==0 || self.viewModel.hotCities.count==0)
    {
        [[self.viewModel.commandGetHomePageData execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)
            {
                [[UIApplication sharedApplication].keyWindow makeToast:x];
            }
            
        }];
    }
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_banner stopTimer];
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
    
    
    
    _banner = [[HomePageBanner alloc] init];
    [_scrollView addSubview:_banner];
    
    
    _selectView = [[HomePageSelectView alloc] init];
    [_scrollView addSubview:_selectView];
    [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
        make.height.mas_equalTo(324);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_banner.mas_bottom).offset(-52);
        
    }];
    
    
    //底部广告
    _advertView = [[HomeMainAdvertView2 alloc] init];
    [_scrollView addSubview:_advertView];
    [_advertView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
        make.height.mas_equalTo(100);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_selectView.mas_bottom).offset(10);
        
    }];
    
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_advertView.mas_bottom).offset(TABBAR_HEIGHT);//对于scrollView来说，bottom时设置contentSize
        
    }];
    
}

- (void)bindViewModel
{
    WS(ws);
    
    RAC(_banner, dataArray) = RACObserve(self.viewModel, bannerData);
    RAC(_advertView, dataArray) = RACObserve(self.viewModel, adData);
    
    RAC(_selectView, city) = RACObserve(self.viewModel, city);
    RAC(_selectView, checkinDate) = RACObserve(self.viewModel, checkinDate);
    RAC(_selectView, checkoutDate) = RACObserve(self.viewModel, checkoutDate);
    RAC(_selectView, searchModel) = RACObserve(self.viewModel, searchModel);
    
    [RACObserve(self.viewModel, today) subscribeNext:^(NSDate *x) {
        
        ws.selectView.today = x;
        ws.viewModel.checkinDate = x;
        ws.viewModel.checkoutDate = [x dateByAddingDays:1];
        
    }];
    
    [RACObserve(_selectView, rentType) subscribeNext:^(NSNumber *x) {
        
        if(x)
        {
            ws.viewModel.rentType = x.integerValue;
            
            if(x.integerValue==0)//短租
            {
                ws.viewModel.city = ws.viewModel.city1;
                ws.viewModel.searchModel = ws.viewModel.searchModel1;
            }
            else if(x.integerValue==1)//长租
            {
                ws.viewModel.city = ws.viewModel.city2;
                ws.viewModel.searchModel = ws.viewModel.searchModel2;
            }
        }
        
    }];
}

- (void)handleEvent
{
    WS(ws);
    @weakify(self);
    
    //取本地持久化数据
    [self.viewModel.commandGetHomePageDataFromLocal execute:nil];
    
    //刷新
    [_refresh addHomeMainRefreshDataBlock:^(HomeMainRefresh *refresh) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[ws.viewModel.commandGetHomePageData execute:nil] subscribeNext:^(NSString *x) {
                
                [refresh finishingLoading];
                
                if(x && x.length)
                {
                    [[UIApplication sharedApplication].keyWindow makeToast:x];
                }
                
            }];
            
        });
        
    }];
    
    
    [[_selectView.citySelectView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"选择城市");
        
        if(ws.viewModel.hotCities.count)
        {
            if(ws.viewModel.rentType==0)
            {
                HomePageCityPickerView *cityPickerView = [[HomePageCityPickerView alloc] initWithCity:ws.viewModel.city1 dataArray:ws.viewModel.hotCities];
                [[UIApplication sharedApplication].keyWindow addSubview:cityPickerView];
                [cityPickerView addHomePageCityPickerViewSelectedBlock:^(NSString *city) {
                    
                    ws.viewModel.city = ws.viewModel.city1 = city;
                    ws.viewModel.searchModel = nil;
                    ws.viewModel.searchModel1 = nil;
                    ws.viewModel.searchModel2 = nil;
                    
                }];
            }
            else if(ws.viewModel.rentType==1)
            {
                HomePageCityPickerView *cityPickerView = [[HomePageCityPickerView alloc] initWithCity:ws.viewModel.city2 dataArray:ws.viewModel.longRentCities];
                [[UIApplication sharedApplication].keyWindow addSubview:cityPickerView];
                [cityPickerView addHomePageCityPickerViewSelectedBlock:^(NSString *city) {
                    
                    ws.viewModel.city = ws.viewModel.city2 = city;
                    ws.viewModel.searchModel = nil;
                    ws.viewModel.searchModel1 = nil;
                    ws.viewModel.searchModel2 = nil;
                    
                }];
            }
            
            
        }
        
    }];
    
    [[_selectView.dateSelectView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"选择日期");
        
        if(ws.viewModel.today)
        {
            if(ws.viewModel.rentType==0)//短租
            {
                HomePageCalendarViewController *calendarVC = [[HomePageCalendarViewController alloc] init];
                calendarVC.viewModel = ws.viewModel;
                [self presentViewController:calendarVC animated:YES completion:nil];
            }
        }
        
    }];
    
    [[_selectView.searchView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"搜索");
        @strongify(self);
        
        SearchViewModel *viewModel = [[SearchViewModel alloc] init];
        viewModel.city = ws.viewModel.city;
        viewModel.homePageViewModel = ws.viewModel;
        PresentVCWithVM(SearchViewController, viewModel);
        
    }];
    
    [[_selectView.searchView.btnClear rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"搜索clear");
        
        if(ws.viewModel.rentType==0)
        {
            ws.viewModel.searchModel = ws.viewModel.searchModel1 = nil;
        }
        else if(ws.viewModel.rentType==1)
        {
            ws.viewModel.searchModel = ws.viewModel.searchModel2 = nil;
        }
        
    }];
    
    [[_selectView.btnCheck rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"查询");
        
        ScreenRoomViewModel *viewModel = [[ScreenRoomViewModel alloc] init];
        viewModel.rentType = ws.viewModel.rentType;
        viewModel.city = ws.viewModel.city;
        
        if(ws.viewModel.rentType==0)//短租
        {
            viewModel.checkinDate = ws.viewModel.checkinDate;
            viewModel.checkoutDate = ws.viewModel.checkoutDate;
        }
        
        if(ws.viewModel.searchModel)
        {
            if(ws.viewModel.searchModel.dataType.integerValue==11)//行政区
            {
                ScreenRoomTagModel *position1 = [[ScreenRoomTagModel alloc] init];
                position1.cname = @"行政区";
                position1.code = @"0";
                
                ScreenRoomTagModel *position2 = [[ScreenRoomTagModel alloc] init];
                position2.cname = ws.viewModel.searchModel.cname;
                position2.code = ws.viewModel.searchModel.code;
                
                viewModel.position1 = position1;
                viewModel.position2 = position2;
            }
            else if(ws.viewModel.searchModel.dataType.integerValue==12)//商圈
            {
                ScreenRoomTagModel *position1 = [[ScreenRoomTagModel alloc] init];
                position1.cname = @"商圈";
                position1.code = @"1";
                
                ScreenRoomTagModel *position2 = [[ScreenRoomTagModel alloc] init];
                position2.cname = ws.viewModel.searchModel.cname;
                position2.code = ws.viewModel.searchModel.code;
                
                viewModel.position1 = position1;
                viewModel.position2 = position2;
            }
            else if(ws.viewModel.searchModel.dataType.integerValue==13)//楼宇
            {
                ScreenRoomTagModel *position1 = [[ScreenRoomTagModel alloc] init];
                position1.cname = @"楼宇";
                position1.code = @"2";
                
                ScreenRoomTagModel *position2 = [[ScreenRoomTagModel alloc] init];
                position2.cname = ws.viewModel.searchModel.cname;
                position2.code = ws.viewModel.searchModel.code;
                
                viewModel.position1 = position1;
                viewModel.position2 = position2;
            }
            else if(ws.viewModel.searchModel.dataType.integerValue==2)//个性化标签
            {
                viewModel.characteristic = @[ws.viewModel.searchModel.code];
            }
        }
        
        PushVCWithVM(ScreenRoomViewController, viewModel);
        
    }];
}







- (RubbishHomePageViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[RubbishHomePageViewModel alloc] init];
    }
    
    return _viewModel;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
