//
//  ScreenRoomRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "ScreenRoomRequestModel.h"
#import "ScreenRoomRespModel.h"

@interface ScreenRoomRequest : XbedRequest

@property (nonatomic, strong)ScreenRoomRequestModel *requestModel;
@property (nonatomic, strong)ScreenRoomRespModel *respModel;

- (id)initWithRequestModel:(ScreenRoomRequestModel *)model;

@end
