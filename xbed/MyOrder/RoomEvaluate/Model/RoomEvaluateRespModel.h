//
//  RoomEvaluateRespModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  房间评价

#import "XbedRespModel.h"
#import "GetRoomEvaluateRespModel.h"

@interface RoomEvaluateDataModel : XbedRespModel

@property (nonatomic, strong)GetRoomEvaluateEvaluatedModel *evaluated;

@end

@interface RoomEvaluateRespModel : XbedRespModel

@property (nonatomic, strong)RoomEvaluateDataModel *data;

@end
