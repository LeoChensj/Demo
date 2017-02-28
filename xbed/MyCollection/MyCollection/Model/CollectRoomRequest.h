//
//  CollectRoomRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "CollectRoomRequestModel.h"
#import "CollectRoomRespModel.h"

@interface CollectRoomRequest : XbedRequest

@property (nonatomic, strong)CollectRoomRequestModel *requestModel;
@property (nonatomic, strong)CollectRoomRespModel *respModel;

- (id)initWithRequestModel:(CollectRoomRequestModel *)model;

@end
