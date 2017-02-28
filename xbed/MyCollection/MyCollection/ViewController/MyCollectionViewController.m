//
//  MyCollectionViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "RoomDetailViewController.h"
#import "LoginViewController.h"

@implementation MyCollectionViewController

@synthesize defaultView = _defaultView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([DBManager getInstance].isLogin)
    {
        [self visitNetworkToMyCollectionRooms];
    }
    else
    {
        self.defaultView.hidden = NO;
        self.defaultView.type = DefaultViewNoLoginWithCollectionRoom;
        self.defaultView.button.tag = 100;
        [self.defaultView.button addTarget:self action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"收藏";
    [self.view addSubview:self.headView];
}

- (void)setupView
{
    _roomListView = [[CollectRoomListView alloc] init];
    [self.view addSubview:_roomListView];
    [_roomListView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
}

- (void)bindViewModel
{
    RAC(_roomListView, dataArray) = RACObserve(self.viewModel, roomListData);
}

- (void)handleEvent
{
    WS(ws);
    
    [_roomListView addRoomListViewDidSelectItemBlock:^(CollectRoomListView *roomListView, CollectRoomListModel *model, NSIndexPath *indexPath) {
        
        RoomDetailViewModel *viewModel = [[RoomDetailViewModel alloc] init];
        viewModel.rentType = model.rentType.integerValue-1;
        viewModel.roomId = model.roomId;
        PushVCWithVM(RoomDetailViewController, viewModel);
        
    } refreshBlock:^(MJRefreshNormalHeader *headerView) {
        
        [[ws.viewModel.commandGetMyCollectionList execute:nil] subscribeNext:^(NSString *x) {
            
            [headerView endRefreshing];
            
            if(x && x.length)
            {
                [[UIApplication sharedApplication].keyWindow makeToast:x];
            }
            
        }];
        
        
    } loadmoreBlock:^(MJRefreshAutoStateFooter *footer) {
        
        [[ws.viewModel.commandGetMoreMyCollectionList execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)
            {
                [[UIApplication sharedApplication].keyWindow makeToast:x];
            }
            else
            {
                if(ws.viewModel.roomListData.count>=ws.viewModel.totalElements.integerValue)
                {
                    ws.roomListView.footer.hidden = YES;
                }
                else
                {
                    ws.roomListView.footer.hidden = NO;
                }
            }
            
            [footer endRefreshing];
            
        }];
        
    } collection:^(CollectionView *view, CollectRoomListModel *roomModel, BOOL flag) {
        
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
        
        
    } off:^(CollectRoomListModel *roomModel) {
        
        //下架
        CollectRoomRequestModel *model = [[CollectRoomRequestModel alloc] init];
        model.roomId = roomModel.roomId;
        model.type = @2;
        
        [[ws.viewModel.commandCollection execute:model] subscribeNext:^(NSString *x) {
            
            if(x==nil)//成功
            {
                NSMutableArray <CollectRoomListModel *>*roomListData = [NSMutableArray arrayWithArray:ws.viewModel.roomListData];
                
                for (NSInteger i=0;i<roomListData.count;i++)
                {
                    if([roomListData[i].roomId isEqualToNumber:roomModel.roomId])
                    {
                        [roomListData removeObjectAtIndex:i];
                        break;
                    }
                }
                ws.viewModel.roomListData = roomListData;
                
            }
            
        }];
        
    }];
}



- (void)visitNetworkToMyCollectionRooms
{
    WS(ws);
    
    [[self.viewModel.commandGetMyCollectionList execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            //[ws.view makeToast:x];
            
            ws.defaultView.hidden = NO;
            ws.defaultView.type = DefaultViewNoNetwork;
            [[ws.defaultView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                [ws visitNetworkToMyCollectionRooms];
                
            }];
        }
        else
        {
            if(ws.viewModel.roomListData.count==0)
            {
                ws.defaultView.hidden = NO;
                ws.defaultView.type = DefaultViewNoCollectionRoom;
                ws.defaultView.button.tag = 101;
                [ws.defaultView.button addTarget:ws action:@selector(defaultViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                ws.defaultView.hidden = YES;
            }
            
            
            if(ws.viewModel.roomListData.count>=ws.viewModel.totalElements.integerValue)
            {
                ws.roomListView.footer.hidden = YES;
            }
            else
            {
                ws.roomListView.footer.hidden = NO;
            }
        }
        
    }];
}


- (void)defaultViewButtonAction:(UIButton *)button
{
    if(button.tag==100)
    {
        PresentVC(LoginViewController);
    }
    else if(button.tag==101)
    {
        [CustomTabBarController getInstance].index = TabBarIndexHome;
    }
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




- (MyCollectionViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[MyCollectionViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}


@end
