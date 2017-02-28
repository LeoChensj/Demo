//
//  GetRoomEvaluateRequest.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  获取房间评价数据

#import "XbedRequest.h"
#import "GetRoomEvaluateRequestModel.h"
#import "GetRoomEvaluateRespModel.h"

@interface GetRoomEvaluateRequest : XbedRequest

@property (nonatomic, strong)GetRoomEvaluateRequestModel *requestModel;
@property (nonatomic, strong)GetRoomEvaluateRespModel *respModel;

- (id)initWithRequestModel:(GetRoomEvaluateRequestModel *)model;

@end
