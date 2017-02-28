//
//  ScreenRoomViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenRoomViewController.h"
#import "ScreenCitySelectView.h"
#import "ScreenCalendarViewController.h"
#import "ScreenPositionViewController.h"
#import "ScreenConditionViewController.h"
#import "ScreenSortView.h"
#import "MapRoomViewController.h"
#import "RoomDetailViewController.h"
#import "LoginViewController.h"

@implementation ScreenRoomViewController

@synthesize defaultView = _defaultView;
@synthesize screenNoRoomView = _screenNoRoomView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    _screenRoomHeadView = [[ScreenRoomHeadView alloc] init];
    _screenRoomHeadView.imgLeft = @"ic_back";
    
    if(self.viewModel.isLocate)
    {
        _screenRoomHeadView.imgvDown.hidden = YES;
    }
    
    //_screenRoomHeadView.imgRight = @"ic_near_room";
    [self.view addSubview:_screenRoomHeadView];
    
    WS(ws);
    [[_screenRoomHeadView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
    
    if(self.viewModel.isLocate==NO)
    {
        [[_screenRoomHeadView.btnTitle rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            NSLog(@"下拉选城市");
            [UIView animateWithDuration:0.2 animations:^{
                
                ws.screenRoomHeadView.imgvDown.transform = CGAffineTransformMakeRotation(-180 * M_PI/180.0);
                
            }];
            
            if(ws.viewModel.cities.count)
            {
                ScreenCitySelectView *citySelectView = [[ScreenCitySelectView alloc] init];
                citySelectView.viewModel = ws.viewModel;
                [ws.view addSubview:citySelectView];
                
                //切换城市
                [citySelectView addScreenCitySelectViewSelectBlock:^(NSString *city) {
                    
                    //清空筛选条件
                    ws.viewModel.checkinDate = nil;
                    ws.viewModel.checkoutDate = nil;
                    ws.viewModel.position1 = nil;
                    ws.viewModel.position2 = nil;
                    ws.viewModel.minPrice = nil;
                    ws.viewModel.maxPrice = nil;
                    ws.viewModel.type = nil;
                    ws.viewModel.bed = nil;
                    ws.viewModel.characteristic = nil;
                    ws.viewModel.sort = nil;
                    
                    
                    [ws visitNetworkToGetAllTagAndRoom];
                    
                } closeBlock:^{
                    
                    [UIView animateWithDuration:0.2 animations:^{
                        
                        ws.screenRoomHeadView.imgvDown.transform = CGAffineTransformMakeRotation(0 * M_PI/180.0);
                        
                    }];
                    
                }];
            }
            
        }];
    }
    
//    [[_screenRoomHeadView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        
//        NSLog(@"地图选房");
//        
//        PushVC(MapRoomViewController, YES);
//        
//    }];
}

- (void)setupView
{
    _conditionView = [[ScreenConditionBar alloc] init];
    _conditionView.viewModel = self.viewModel;
    [self.view addSubview:_conditionView];
    [_conditionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    if(self.viewModel.isLocate)
    {
        ScreenRoomTagModel *sortModel = [[ScreenRoomTagModel alloc] init];
        sortModel.cname = @"距离优先";
        sortModel.code = nil;
        
        self.viewModel.sort = sortModel;
    }
    
    
    _roomListView = [[RoomListView alloc] init];
    [self.view addSubview:_roomListView];
    [_roomListView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_conditionView.mas_bottom).offset(0);
        
    }];
}

- (void)bindViewModel
{
    RAC(self.screenRoomHeadView, title) = RACObserve(self.viewModel, city);
    RAC(_roomListView, dataArray) = RACObserve(self.viewModel, roomListData);
}

- (void)handleEvent
{
    WS(ws);
    [self visitNetworkToGetAllTag];
    
    [[_conditionView.item1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"日期");
        
        ScreenCalendarViewController *calendarVC = [[ScreenCalendarViewController alloc] init];
        calendarVC.viewModel = ws.viewModel;
        [ws presentViewController:calendarVC animated:YES completion:nil];
        
    }];
    
    
    [[_conditionView.item2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"位置");
        
        ScreenPositionViewController *positionVC = [[ScreenPositionViewController alloc] init];
        positionVC.viewModel = ws.viewModel;
        [ws presentViewController:positionVC animated:YES completion:nil];
        
    }];
    
    
    [[_conditionView.item3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"筛选");
        
        ScreenConditionViewController *conditionVC = [[ScreenConditionViewController alloc] init];
        conditionVC.viewModel = ws.viewModel;
        [ws presentViewController:conditionVC animated:YES completion:nil];
        
    }];
    
    [[_conditionView.item4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"排序");
        
        ScreenSortView *sortView = [[ScreenSortView alloc] init];
        sortView.viewModel = ws.viewModel;
        [ws.view addSubview:sortView];
        
    }];
    
    
    //筛选
    [self.viewModel.signalScreen subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            [ws visitNetworkToScreenRoom];
        }
        
    }];
    
    
    
    //房间列表回调
    @weakify(self);
    [_roomListView addRoomListViewRefreshBlock:^(MJRefreshNormalHeader *headerView) {
        
        [[ws.viewModel.commandGetRoomList execute:nil] subscribeNext:^(NSString *x) {
            
            [headerView endRefreshing];
            
            if(x && x.length)
            {
                [ws.view makeToast:x];
            }
            
        }];
        
    } didSelectItemBlock:^(RoomListView *roomListView, ScreenRoomListModel *model, NSIndexPath *indexPath) {
        
        RoomDetailViewModel *viewModel = [[RoomDetailViewModel alloc] init];
        viewModel.roomId = model.roomId;
        viewModel.rentType = ws.viewModel.rentType;
        viewModel.collection = model.collected;
        
        //同步收藏状态
        @strongify(self);
        [RACObserve(viewModel, collection) subscribeNext:^(NSNumber *x) {
            
            model.collected = x;
            [ws.roomListView reloadData];
            
        }];
        PushVCWithVM(RoomDetailViewController, viewModel);
        
    } loadmoreBlock:^(MJRefreshAutoStateFooter *footerView) {
        
        [[ws.viewModel.commandGetMoreRoomList execute:nil] subscribeNext:^(NSString *x) {
            
            if(x.length)
            {
                [ws.view makeToast:x];
            }
            
            [footerView endRefreshing];
            
            if(ws.viewModel.roomListData.count==ws.viewModel.totalElements.integerValue)
            {
                footerView.hidden = YES;
            }
            
        }];
        
    } collection:^(CollectionView *view, ScreenRoomListModel *roomModel, BOOL flag) {
        
        if([DBManager getInstance].isLogin)
        {
            CollectRoomRequestModel *model = [[CollectRoomRequestModel alloc] init];
            model.roomId = roomModel.roomId;
            if(flag)
            {
                model.type = @1;
                model.rentType = roomModel.rentType;
            }
            else
                model.type = @2;
            
            [[ws.viewModel.commandCollection execute:model] subscribeNext:^(NSString *x) {
                
                if(x && x.length)
                {
                    [view changeStatesWithAnimate:NO];
                }
                
            }];
        }
        else
        {
            @strongify(self);
            PresentVC(LoginViewController);
        }
        
    }];
}




- (void)visitNetworkToGetAllTag
{
    WS(ws);
    
    [[self.viewModel.commandGetAllTag execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)//失败
        {
            //[ws.view makeToast:x];
            
            ws.defaultView.hidden = NO;
            ws.defaultView.type = DefaultViewNoNetwork;
            [[ws.defaultView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                [ws visitNetworkToGetAllTag];
                
            }];
        }
        /*
        else//成功
        {
            if(ws.viewModel.roomListData.count==0)
            {
                ws.defaultView.hidden = NO;
                ws.defaultView.type = DefaultViewNoConditonRoom;
            }
            else
            {
                ws.defaultView.hidden = YES;
                [_roomListView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
        */
        
        if(ws.viewModel.roomListData.count==ws.viewModel.totalElements.integerValue)
        {
            ws.roomListView.footer.hidden = YES;
        }
        
    }];
}


- (void)visitNetworkToGetAllTagAndRoom
{
    WS(ws);
    
    [[self.viewModel.commandGetAllTagAndRoomList execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)//失败
        {
            //[ws.view makeToast:x];
            
            ws.defaultView.hidden = NO;
            ws.defaultView.type = DefaultViewNoNetwork;
            [[ws.defaultView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                [ws visitNetworkToGetAllTagAndRoom];
                
            }];
        }
        /*
        else//成功
        {
            if(ws.viewModel.roomListData.count==0)
            {
                ws.defaultView.hidden = NO;
                ws.defaultView.type = DefaultViewNoConditonRoom;
            }
            else
            {
                ws.defaultView.hidden = YES;
                [_roomListView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
        */
        
        if(ws.viewModel.roomListData.count==ws.viewModel.totalElements.integerValue)
        {
            ws.roomListView.footer.hidden = YES;
        }
        
    }];
}


- (void)visitNetworkToScreenRoom
{
    WS(ws);
    
    [[ws.viewModel.commandGetRoomList execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)//访问失败
        {
            //[ws.view makeToast:x];
            
            ws.defaultView.hidden = NO;
            ws.defaultView.type = DefaultViewNoNetwork;
            [[ws.defaultView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                [ws visitNetworkToScreenRoom];
                
            }];
            
        }
        else//访问成功
        {
            if(ws.viewModel.roomListData.count==0)
            {
//                ws.defaultView.hidden = NO;
//                ws.defaultView.type = DefaultViewNoConditonRoom;
                
                ws.defaultView.hidden = YES;
                
                ws.screenNoRoomView.hidden = NO;
                ws.screenNoRoomView.dataArray = ws.viewModel.selectScreenModel;
                
                
                [ws.screenNoRoomView addScreenNoRoomCollectionViewDeleteBlock:^(ScreenRoomTagModel *model, NSIndexPath *indexPath) {
                    
                    NSMutableArray <ScreenRoomTagModel *>*mArr = [NSMutableArray arrayWithArray:ws.viewModel.selectScreenModel];
                    [mArr removeObject:model];
                    ws.screenNoRoomView.dataArray = ws.viewModel.selectScreenModel = mArr;
                    
                    
                    if(model.type.integerValue==1)
                    {
                        ws.viewModel.checkinDate = nil;
                        ws.viewModel.checkoutDate = nil;
                    }
                    else if(model.type.integerValue==2)
                    {
                        ws.viewModel.position1 = nil;
                        ws.viewModel.position2 = nil;
                    }
                    else if(model.type.integerValue==3)
                    {
                        ws.viewModel.minPrice = nil;
                        ws.viewModel.maxPrice = nil;
                    }
                    else if(model.type.integerValue==4)
                    {
                        NSMutableArray <NSString *>*mType = [NSMutableArray arrayWithArray:ws.viewModel.type];
                        for (NSInteger i=0;i<mType.count;i++)
                        {
                            if([mType[i] isEqualToString:model.code])
                            {
                                [mType removeObjectAtIndex:i];
                                break;
                            }
                        }
                        
                        ws.viewModel.type = mType;
                    }
                    else if(model.type.integerValue==5)
                    {
                        ws.viewModel.bed = nil;
                    }
                    else if(model.type.integerValue==6)
                    {
                        NSMutableArray <NSString *>*mCharacteristic = [NSMutableArray arrayWithArray:ws.viewModel.characteristic];
                        for (NSInteger i=0;i<mCharacteristic.count;i++)
                        {
                            if([mCharacteristic[i] isEqualToString:model.code])
                            {
                                [mCharacteristic removeObjectAtIndex:i];
                                break;
                            }
                        }
                        
                        ws.viewModel.characteristic = mCharacteristic;
                    }
                    
                }];
            }
            else
            {
                ws.defaultView.hidden = YES;
                
                ws.screenNoRoomView.hidden = YES;
                ws.screenNoRoomView.dataArray = nil;
                
                [_roomListView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
        
        if(ws.viewModel.roomListData.count==ws.viewModel.totalElements.integerValue)
        {
            ws.roomListView.footer.hidden = YES;
        }
        
    }];
}




- (ScreenNoRoomView *)screenNoRoomView
{
    if(_screenNoRoomView==nil)
    {
        _screenNoRoomView = [[ScreenNoRoomView alloc] init];
        [self.view addSubview:_screenNoRoomView];
        [_screenNoRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64-49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(64+49);
            
        }];
    }
    
    return _screenNoRoomView;
}

- (DefaultView *)defaultView
{
    if(_defaultView==nil)
    {
        _defaultView = [[DefaultView alloc] init];
        [self.view addSubview:_defaultView];
    }
    
    return _defaultView;
}


- (ScreenRoomViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[ScreenRoomViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}



@end
