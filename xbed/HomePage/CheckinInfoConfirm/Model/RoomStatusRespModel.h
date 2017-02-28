//
//  RoomStatusRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"
#import "RoomDetailRespModel.h"

@interface RoomStatusRespModel : XbedRespModel

@property (nonatomic, strong)NSArray <RoomDetailRoomStatusModel *>*data;

@end
