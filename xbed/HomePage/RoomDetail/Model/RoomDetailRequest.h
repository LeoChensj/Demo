//
//  RoomDetailRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "RoomDetailRequestModel.h"
#import "RoomDetailRespModel.h"

@interface RoomDetailRequest : XbedRequest

@property (nonatomic, strong)RoomDetailRequestModel *requestModel;
@property (nonatomic, strong)RoomDetailRespModel *respModel;

- (id)initWithRequestModel:(RoomDetailRequestModel *)model;

@end
