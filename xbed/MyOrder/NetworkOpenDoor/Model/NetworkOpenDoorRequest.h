//
//  NetworkOpenDoorRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  网络开门  需要校验

#import "XbedRequest.h"
#import "NetworkOpenDoorRequestModel.h"
#import "NetworkOpenDoorRespModel.h"

@interface NetworkOpenDoorRequest : XbedRequest

@property (nonatomic, strong)NetworkOpenDoorRequestModel *requestModel;
@property (nonatomic, strong)NetworkOpenDoorRespModel *respModel;

- (id)initWithRequestModel:(NetworkOpenDoorRequestModel *)model;

@end
