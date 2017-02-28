//
//  RoomListCell.h
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenRoomRespModel.h"
#import "PriceView.h"
#import "CollectionView.h"
#import "RoomDescribeLabel.h"

#define RoomListCellWidth   MAIN_SCREEN_WIDTH
#define RoomListCellHeight  (MAIN_SCREEN_WIDTH*2/3+64)


@class RoomListCell;
typedef void (^RoomListCellCollectionTouchBlock)(CollectionView *view, ScreenRoomListModel *roomModel, BOOL flag);//flag:YES收藏，NO取消收藏

@interface RoomListCell : UICollectionViewCell
{
@private
    UIImageView *_imgvRoom;
    PriceView *_vPrice;
    CollectionView *_vCollection;
    UILabel *_lbTitle;
    RoomDescribeLabel *_lbDescribe;
    UILabel *_lbDistance;
}

@property (nonatomic, strong)ScreenRoomListModel *model;
@property (nonatomic, strong)RoomListCellCollectionTouchBlock block;

- (void)addRoomListCellCollectionTouchBlock:(RoomListCellCollectionTouchBlock)block;

@end
