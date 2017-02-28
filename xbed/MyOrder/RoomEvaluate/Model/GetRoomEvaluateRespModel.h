//
//  GetRoomEvaluateRespModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  获取房间评价数据

#import "XbedRespModel.h"
#import "RoomDetailRespModel.h"

@interface GetRoomEvaluateTermListModel : XbedRespModel

@property (nonatomic, strong)NSNumber *termId;
@property (nonatomic, strong)NSString *termName;

@end

@interface GetRoomEvaluateStarTermModel : XbedRespModel

@property (nonatomic, strong)NSNumber *starId;
@property (nonatomic, strong)NSArray <GetRoomEvaluateTermListModel *>*termList;

@end

@interface GetRoomEvaluateWaitEvaluateModel : XbedRespModel

@property (nonatomic, strong)NSArray <GetRoomEvaluateStarTermModel *>*cleanStarTerm;
@property (nonatomic, strong)NSArray <GetRoomEvaluateStarTermModel *>*roomStarTerm;

@end

@interface GetRoomEvaluateOverdueModel : XbedRespModel

@property (nonatomic, strong)NSArray <RoomDetailNearRoomsModel *>*nearRoomList;

@end

@interface GetRoomEvaluateEvaluatedModel : XbedRespModel

@property (nonatomic, strong)NSNumber *cleanStar;
@property (nonatomic, strong)NSArray <NSString *>*cleanTermList;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSArray <RoomDetailNearRoomsModel *>*nearRoomList;
@property (nonatomic, strong)NSArray <NSString *>*picList;
@property (nonatomic, strong)NSNumber *roomStar;
@property (nonatomic, strong)NSArray <NSString *>*roomTermList;

@end

@interface GetRoomEvaluateDataModel : XbedRespModel

@property (nonatomic, strong)GetRoomEvaluateWaitEvaluateModel *waitEvaluate;
@property (nonatomic, strong)GetRoomEvaluateEvaluatedModel *evaluated;
@property (nonatomic, strong)GetRoomEvaluateOverdueModel *overdue;

@end

@interface GetRoomEvaluateRespModel : XbedRespModel

@property (nonatomic, strong)GetRoomEvaluateDataModel *data;

@end
