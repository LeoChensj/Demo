//
//  SearchViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/7/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SearchViewController.h"
#import "ScreenRoomViewController.h"

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    [self setupPopGestureRecognizerEnable:NO];
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)setupNavigationBar
{
    _searchHeadView = [[SearchHeadView alloc] init];
    [self.view addSubview:_searchHeadView];
    [_searchHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(64);
        make.left.top.mas_equalTo(0);
        
    }];
    
    @weakify(self);
    [[_searchHeadView.btnCancel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self);
        DismissVC(YES);
        
    }];
    
}

- (void)setupView
{
//    _vContent1 = [[UIView alloc] init];
//    _vContent1.backgroundColor = Background_Color;
//    [self.view addSubview:_vContent1];
//    [_vContent1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
//        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
//        make.left.mas_equalTo(0);
//        make.top.mas_equalTo(_searchHeadView.mas_bottom).offset(0);
//        
//    }];
//    
//    _locateView = [[SearchLocateView alloc] init];
//    [_vContent1 addSubview:_locateView];
//    [_locateView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
//        make.height.mas_equalTo(50);
//        make.left.mas_equalTo(0);
//        make.top.mas_equalTo(_searchHeadView.mas_bottom).offset(15);
//        
//    }];
//    [_locateView startLocate];
//    
//    
//    
//    
//    _hotCityView = [[HotCityView alloc] init];
//    [_vContent1 addSubview:_hotCityView];
//    [_hotCityView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
//        make.height.mas_equalTo(90);
//        make.left.mas_equalTo(0);
//        make.top.mas_equalTo(_locateView.mas_bottom).offset(0);
//        
//    }];
//    
//    
//    _recordView = [[SearchRecordView alloc] init];
//    [_vContent1 addSubview:_recordView];
//    [_recordView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
//        make.left.mas_equalTo(0);
//        make.top.mas_equalTo(_hotCityView.mas_bottom).offset(0);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
//        
//    }];
    
    _associateView = [[SearchAssociateView alloc] init];
    [self.view addSubview:_associateView];
    [_associateView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
}

- (void)bindViewModel
{
    WS(ws);
    [_searchHeadView.tfSearch.rac_textSignal subscribeNext:^(id x) {
        
        ws.viewModel.markedTextRange = ws.searchHeadView.tfSearch.markedTextRange;
        ws.viewModel.inputText = ws.searchHeadView.tfSearch.text;
        
    }];
    //RAC(self.viewModel, locateCity) = RACObserve(_locateView, locateCity);
    //RAC(self.viewModel, longitude) = RACObserve(_locateView, longitude);
    //RAC(self.viewModel, latitude) = RACObserve(_locateView, latitude);
    //RAC(_hotCityView, dataArray) = RACObserve(self.viewModel, hotCityData);
    //RAC(_recordView, dataArray) = RACObserve(self.viewModel, recordData);
    
    [RACObserve(self.viewModel, associateListData) subscribeNext:^(NSArray <SearchDataModel *>*x) {
        
        ws.associateView.dataArray = x;
        
        if(x) //dataArray.count==0也不隐藏
        {
            ws.associateView.hidden = NO;
        }
        else
        {
            ws.associateView.hidden = YES;
        }
    }];
    
    
    
    if(self.viewModel.homePageViewModel.searchModel.cname)
    {
        _searchHeadView.tfSearch.text = self.viewModel.homePageViewModel.searchModel.cname;
    }
}

- (void)handleEvent
{
    WS(ws);
    @weakify(self);
    
    //[self.viewModel.commandGetHotCityFromLocal execute:nil];
    
    //[self.viewModel.commandGetHotCityFromNetwork execute:nil];
    
    
//    [[_locateView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        
//        NSLog(@"定位城市");
//        
//        ScreenRoomViewModel *viewModel = [[ScreenRoomViewModel alloc] init];
//        
//        NSString *city;
//        if([[ws.viewModel.locateCity substringWithRange:NSMakeRange(ws.viewModel.locateCity.length-1, 1)] isEqualToString:@"市"])
//        {
//            city = ws.viewModel.locateCity;
//        }
//        else
//        {
//            city = [NSString stringWithFormat:@"%@市", ws.viewModel.locateCity];
//        }
//        
//        viewModel.city = city;
//        viewModel.isLocate = YES;
//        viewModel.longitude = ws.viewModel.longitude;
//        viewModel.latitude = ws.viewModel.latitude;
//        PushVCWithVM(ScreenRoomViewController, viewModel);
//        
//    }];
    
//    [_hotCityView addHotCityViewDidSelectItemBlock:^(HotCityView *hotCityView, NSString *model, NSIndexPath *indexPath) {
//        
//        NSLog(@"热门城市=%@", model);
//        
//        ScreenRoomViewModel *viewModel = [[ScreenRoomViewModel alloc] init];
//        
//        NSString *city;
//        if([[model substringWithRange:NSMakeRange(model.length-1, 1)] isEqualToString:@"市"])
//        {
//            city = model;
//        }
//        else
//        {
//            city = [NSString stringWithFormat:@"%@市", model];
//        }
//        
//        viewModel.city = city;
//        PushVCWithVM(ScreenRoomViewController, viewModel);
//        
//    }];
    
    
    [self.viewModel.signalInput subscribeNext:^(NSString *x) {
        
        if(x)
        {
            NSLog(@"联想=%@", x);
            
            ws.associateView.associateContent = x;
            
            [[ws.viewModel.commandGetAssociateData execute:nil] subscribeNext:^(NSString *x) {
                
                if(x && x.length)
                {
                    [ws.view makeToast:x];
                }
                
            }];
        }
        
    }];
    
    
    [_associateView addSearchAssociateViewDidSelectRowBlock:^(SearchAssociateView *tableView, SearchModel *model, NSIndexPath *indexPath) {
        
        NSLog(@"联想搜索=%@", model);
        @strongify(self);
        
//        ScreenRoomViewModel *viewModel = [[ScreenRoomViewModel alloc] init];
//        
//        NSString *city;
//        if([[model.city substringWithRange:NSMakeRange(model.city.length-1, 1)] isEqualToString:@"市"])
//        {
//            city = model.city;
//        }
//        else
//        {
//            city = [NSString stringWithFormat:@"%@市", model.city];
//        }
//        
//        ScreenRoomTagModel *position = [[ScreenRoomTagModel alloc] init];
//        position.code = model.code;
//        
//        viewModel.city = city;
//        viewModel.position2 = position;
//        PushVCWithVM(ScreenRoomViewController, viewModel);
        
//        //保存搜索记录
//        SearchRecordModel *record = [[SearchRecordModel alloc] init];
//        record.city = city;
//        record.cname = model.cname;
//        record.positionCode = model.code;
//        [ws.viewModel.commandAddSearchRecord execute:record];
        
        
        
        
        if(ws.viewModel.homePageViewModel.rentType==0)
        {
            ws.viewModel.homePageViewModel.searchModel = ws.viewModel.homePageViewModel.searchModel1 = model;
        }
        else if(ws.viewModel.homePageViewModel.rentType==1)
        {
            ws.viewModel.homePageViewModel.searchModel = ws.viewModel.homePageViewModel.searchModel2 = model;
        }
        
        DismissVC(YES);
        
        
    }];
    
    
    
    
//    [_recordView addSearchRecordViewDidSelectRowBlock:^(SearchRecordView *tableView, SearchRecordModel *model, NSIndexPath *indexPath) {
//        
//        ScreenRoomViewModel *viewModel = [[ScreenRoomViewModel alloc] init];
//        
//        NSString *city;
//        if([[model.city substringWithRange:NSMakeRange(model.city.length-1, 1)] isEqualToString:@"市"])
//        {
//            city = model.city;
//        }
//        else
//        {
//            city = [NSString stringWithFormat:@"%@市", model.city];
//        }
//        
//        viewModel.city = city;
//        
//        if(model.positionCode.length)
//        {
//            ScreenRoomTagModel *position = [[ScreenRoomTagModel alloc] init];
//            position.code = model.positionCode;
//            viewModel.position2 = position;
//        }
//        
//        PushVCWithVM(ScreenRoomViewController, viewModel);
//        
//    } didClearBlock:^{
//        
//        NSLog(@"清空搜索历史");
//        
//        [ws.viewModel.commandClearSearchRecord execute:nil];
//        
//    }];
    
}



- (SearchViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[SearchViewModel alloc] init];
    }
    
    return _viewModel;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}


@end
