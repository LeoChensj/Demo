//
//  MyCollectionViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "MyCollectionViewModel.h"
#import "CollectRoomListView.h"
#import "DefaultView.h"

@interface MyCollectionViewController : XbedViewController

@property (nonatomic, strong, readonly)CollectRoomListView *roomListView;
@property (nonatomic, strong, readonly)DefaultView *defaultView;

@property (nonatomic, strong)MyCollectionViewModel *viewModel;

@end
