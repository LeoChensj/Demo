//
//  RoomEvaluateRequest.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  房间评价

#import "XbedRequest.h"
#import "RoomEvaluateRequestModel.h"
#import "RoomEvaluateRespModel.h"

@interface RoomEvaluateRequest : XbedRequest

@property (nonatomic, strong)RoomEvaluateRequestModel *requestModel;
@property (nonatomic, strong)RoomEvaluateRespModel *respModel;

- (id)initWithRequestModel:(RoomEvaluateRequestModel *)model;

@end
