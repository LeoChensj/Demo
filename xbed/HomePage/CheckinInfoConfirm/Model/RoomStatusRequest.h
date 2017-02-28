//
//  RoomStatusRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  查询远期房态

#import "XbedRequest.h"
#import "RoomStatusRequestModel.h"
#import "RoomStatusRespModel.h"

@interface RoomStatusRequest : XbedRequest

@property (nonatomic, strong)RoomStatusRequestModel *requestModel;
@property (nonatomic, strong)RoomStatusRespModel *respModel;

- (id)initWithRequestModel:(RoomStatusRequestModel *)model;

@end
