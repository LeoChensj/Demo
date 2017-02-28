//
//  GetRoomEvaluateRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  获取房间评价数据

#import "XbedRequestModel.h"

@interface GetRoomEvaluateRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSNumber *roomId;

@end
