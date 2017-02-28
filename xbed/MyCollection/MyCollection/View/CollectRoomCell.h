//
//  CollectRoomCell.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomListCell.h"
#import "PriceView.h"
#import "CollectionView.h"
#import "RoomDescribeLabel.h"
#import "CollectRoomListRespModel.h"

@class CollectRoomCell;
typedef void (^CollectRoomCellCollectionTouchBlock)(CollectionView *view, CollectRoomListModel *roomModel, BOOL flag);//flag:YES收藏，NO取消收藏
typedef void (^CollectRoomCellRoomOffBlock)(CollectRoomListModel *roomModel);

@interface CollectRoomCell : UITableViewCell
{
@private
    UIImageView *_imgvRoom;
    PriceView *_vPrice;
    CollectionView *_vCollection;
    UILabel *_lbTitle;
    RoomDescribeLabel *_lbDescribe;
    
    UIView *_vBlack;
    UIButton *_btnDelete;//删除下架的
    UILabel *_lbOff;
}

@property (nonatomic, strong)CollectRoomListModel *model;
@property (nonatomic, strong)CollectRoomCellCollectionTouchBlock blockCollection;
@property (nonatomic, strong)CollectRoomCellRoomOffBlock blockOff;

- (void)addCollectRoomCellCollectionTouchBlock:(CollectRoomCellCollectionTouchBlock)blockCollection collectRoomCellRoomOffBlock:(CollectRoomCellRoomOffBlock)blockOff;

@end
