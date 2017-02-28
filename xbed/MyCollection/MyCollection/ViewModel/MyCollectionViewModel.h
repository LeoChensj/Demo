//
//  MyCollectionViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "CollectRoomListRespModel.h"
#import "CollectRoomRequestModel.h"

@interface MyCollectionViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *page;
@property (nonatomic, strong)NSNumber *size;
@property (nonatomic, strong)NSArray <CollectRoomListModel *>*roomListData;
@property (nonatomic, strong)NSNumber *totalElements;

@property (nonatomic, strong, readonly)RACCommand *commandGetMyCollectionList;
@property (nonatomic, strong, readonly)RACCommand *commandGetMoreMyCollectionList;
@property (nonatomic, strong, readonly)RACCommand *commandCollection;

@end
