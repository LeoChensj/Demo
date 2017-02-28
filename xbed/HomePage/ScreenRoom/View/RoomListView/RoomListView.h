//
//  RoomListView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomListCell.h"
#import "MJRefresh.h"

@class RoomListView;
typedef void (^RoomListViewDidSelectItemBlock)(RoomListView *roomListView, ScreenRoomListModel *model, NSIndexPath *indexPath);
typedef void (^RoomListViewLoadmoreBlock)(MJRefreshAutoStateFooter *footerView);
typedef void (^RoomListViewRefreshBlock)(MJRefreshNormalHeader *headerView);

@interface RoomListView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSArray <ScreenRoomListModel *>*dataArray;
@property (nonatomic, strong)RoomListViewRefreshBlock refreshBlock;
@property (nonatomic, strong)RoomListViewDidSelectItemBlock selectItemBlock;
@property (nonatomic, strong)RoomListViewLoadmoreBlock loadMoreBlock;
@property (nonatomic, strong)RoomListCellCollectionTouchBlock collectionBlock;

@property (nonatomic, strong, readonly)MJRefreshNormalHeader *header;
@property (nonatomic, strong, readonly)MJRefreshAutoStateFooter *footer;


- (void)addRoomListViewRefreshBlock:(RoomListViewRefreshBlock)refreshBlock didSelectItemBlock:(RoomListViewDidSelectItemBlock)selectItemBlock loadmoreBlock:(RoomListViewLoadmoreBlock)loadMoreBlock collection:(RoomListCellCollectionTouchBlock)collectionBlock;

@end
