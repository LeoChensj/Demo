//
//  RoomCommentListRequest.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "RoomCommentListRequestModel.h"
#import "RoomCommentListRespModel.h"

@interface RoomCommentListRequest : XbedRequest

@property (nonatomic, strong)RoomCommentListRequestModel *requestModel;
@property (nonatomic, strong)RoomCommentListRespModel *respModel;

- (id)initWithRequestModel:(RoomCommentListRequestModel *)model;

@end
