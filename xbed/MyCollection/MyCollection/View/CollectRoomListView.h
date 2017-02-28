//
//  CollectRoomListView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectRoomCell.h"
#import "MJRefresh.h"

@class CollectRoomListView;
typedef void (^CollectRoomListViewDidSelectItemBlock)(CollectRoomListView *roomListView, CollectRoomListModel *model, NSIndexPath *indexPath);
typedef void (^CollectRoomListViewRefreshBlock)(MJRefreshNormalHeader *headerView);
typedef void (^CollectRoomListViewLoadmoreBlock)(MJRefreshAutoStateFooter *footer);

@interface CollectRoomListView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray <CollectRoomListModel *>*dataArray;
@property (nonatomic, strong)CollectRoomListViewDidSelectItemBlock selectItemBlock;
@property (nonatomic, strong)CollectRoomListViewRefreshBlock refreshBlock;
@property (nonatomic, strong)CollectRoomListViewLoadmoreBlock loadMoreBlock;
@property (nonatomic, strong)CollectRoomCellCollectionTouchBlock collectionBlock;
@property (nonatomic, strong)CollectRoomCellRoomOffBlock offBlock;

@property (nonatomic, strong, readonly)MJRefreshNormalHeader *header;
@property (nonatomic, strong, readonly)MJRefreshAutoStateFooter *footer;

- (void)addRoomListViewDidSelectItemBlock:(CollectRoomListViewDidSelectItemBlock)selectItemBlock refreshBlock:(CollectRoomListViewRefreshBlock)refreshBlock loadmoreBlock:(CollectRoomListViewLoadmoreBlock)loadMoreBlock collection:(CollectRoomCellCollectionTouchBlock)collectionBlock off:(CollectRoomCellRoomOffBlock)offBlock;

@end
