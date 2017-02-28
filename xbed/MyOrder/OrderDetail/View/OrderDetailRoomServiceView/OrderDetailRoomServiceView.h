//
//  OrderDetailRoomServiceView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  房间服务 六宫格

#import <UIKit/UIKit.h>
#import "OrderDetailRoomServiceCell.h"

@interface OrderDetailRoomServiceView : UIView

@property (nonatomic, strong, readonly)OrderDetailRoomServiceCell *cellClean;
@property (nonatomic, strong, readonly)OrderDetailRoomServiceCell *cellWifi;
@property (nonatomic, strong, readonly)OrderDetailRoomServiceCell *cellDoor;
@property (nonatomic, strong, readonly)OrderDetailRoomServiceCell *cellCheckin;
@property (nonatomic, strong, readonly)OrderDetailRoomServiceCell *cellOpinion;
@property (nonatomic, strong, readonly)OrderDetailRoomServiceCell *cellEvaluate;

@property (nonatomic, assign, readonly)CGFloat myHeight;

@end
