//
//  CollectRoomListRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "CollectRoomListRequestModel.h"
#import "CollectRoomListRespModel.h"

@interface CollectRoomListRequest : XbedRequest

@property (nonatomic, strong)CollectRoomListRequestModel *requestModel;
@property (nonatomic, strong)CollectRoomListRespModel *respModel;

- (id)initWithRequestModel:(CollectRoomListRequestModel *)model;

@end
