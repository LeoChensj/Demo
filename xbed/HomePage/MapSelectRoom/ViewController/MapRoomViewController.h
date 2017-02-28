//
//  MapRoomViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  地图选房

#import "XbedViewController.h"
#import "MapRoomViewModel.h"
#import "ScreenRoomHeadView.h"
#import "MapRoomView.h"

@interface MapRoomViewController : XbedViewController

@property (nonatomic, strong, readonly)ScreenRoomHeadView *mapRoomHeadView;
@property (nonatomic, strong, readonly)MapRoomView *mapRoomView;

@property (nonatomic, strong)MapRoomViewModel *viewModel;

@end
