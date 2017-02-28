//
//  RoomEvaluateListViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "RoomEvaluateListViewModel.h"
#import "LoadmoreScrollView.h"
#import "RoomEvaluateListScoreView.h"
#import "RoomEvaluateListView.h"

@interface RoomEvaluateListViewController : XbedViewController

@property (nonatomic, strong, readonly)LoadmoreScrollView *scrollView;
@property (nonatomic, strong, readonly)RoomEvaluateListScoreView *scoreView;
@property (nonatomic, strong, readonly)RoomEvaluateListView *listView;

@property (nonatomic, strong)RoomEvaluateListViewModel *viewModel;

@end
