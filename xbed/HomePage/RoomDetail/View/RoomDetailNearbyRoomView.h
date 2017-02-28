//
//  RoomDetailNearbyRoomView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  附近房源

#import <UIKit/UIKit.h>
#import "MovieImageBrowser.h"
#import "NearbyRoomModel.h"
#import "RoomDescribeLabel.h"

@class RoomDetailNearbyRoomView;
typedef void (^RoomDetailNearbyRoomViewDidSelectItemBlock)(RoomDetailNearbyRoomView *view, NearbyRoomModel *model, NSInteger index);


@interface RoomDetailNearbyRoomView : UIView <NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
{
@private
    UILabel *_lbTitle;
    NewPagedFlowView *_pageFlowView;
    UILabel *_lbRoomTitle;
    RoomDescribeLabel *_lbDescribe;
    UILabel *_lbDistance;
    UILabel *_lbPrice;
}

@property (nonatomic, strong)NSArray <NearbyRoomModel *>*dataArray;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)RoomDetailNearbyRoomViewDidSelectItemBlock block;

- (void)addRoomDetailNearbyRoomViewDidSelectItemBlock:(RoomDetailNearbyRoomViewDidSelectItemBlock)block;

@end
