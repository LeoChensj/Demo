//
//  ScreenRoomViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  筛选房间

#import "XbedViewController.h"
#import "ScreenRoomViewModel.h"
#import "ScreenRoomHeadView.h"
#import "ScreenConditionBar.h"
#import "RoomListView.h"
#import "DefaultView.h"
#import "ScreenNoRoomView.h"

@interface ScreenRoomViewController : XbedViewController

@property (nonatomic, strong, readonly)ScreenRoomHeadView *screenRoomHeadView;
@property (nonatomic, strong, readonly)ScreenConditionBar *conditionView;
@property (nonatomic, strong, readonly)RoomListView *roomListView;
@property (nonatomic, strong, readonly)DefaultView *defaultView;
@property (nonatomic, strong, readonly)ScreenNoRoomView *screenNoRoomView;

@property (nonatomic, strong)ScreenRoomViewModel *viewModel;

@end
