//
//  RoomDetailRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"
#import "ScreenRoomRespModel.h"

@interface RoomDetailRoomStatusModel : XbedModel

@property (nonatomic, strong)NSDate *calendarDate;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSNumber *state;

@end

@interface RoomDetailNearRoomsModel : XbedModel

@property (nonatomic, strong)NSNumber *cleanGrade;
@property (nonatomic, strong)NSString *coverPic;
@property (nonatomic, strong)NSString *custRoomName;
@property (nonatomic, strong)NSNumber *distance;
@property (nonatomic, strong)NSString *houseType;
@property (nonatomic, strong)NSNumber *liveCount;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSNumber *roomGrade;
@property (nonatomic, strong)NSNumber *roomId;

@end

@interface RoomDetailCommentModel : XbedModel

@property (nonatomic, strong)NSNumber *cleanGrade;
@property (nonatomic, strong)NSNumber *commentsCount;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSNumber *roomGrade;

@end

@interface RoomDetailBaseInfoModel : XbedModel

@property (nonatomic, strong)NSString *area;
@property (nonatomic, strong)NSString *bedDescribe;
@property (nonatomic, strong)NSNumber *cleanGrade;
@property (nonatomic, strong)NSNumber *collected;
@property (nonatomic, strong)NSString *custRoomAddr;
@property (nonatomic, strong)NSString *custRoomAddrPic;
@property (nonatomic, strong)NSString *custRoomName;
@property (nonatomic, strong)NSString *custRoomNo;
@property (nonatomic, strong)NSNumber *flag;
@property (nonatomic, strong)NSNumber *hasFullView;
@property (nonatomic, strong)NSString *houseType;
@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSNumber *liveCount;
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSNumber *roomFloor;
@property (nonatomic, strong)NSNumber *roomGrade;
@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSString *roomTypeName;

@end

@interface RoomDetailAdditionModel : XbedModel

@property (nonatomic, strong)NSArray <NSString *>*guide;
@property (nonatomic, strong)NSArray <NSString *>*tag;
@property (nonatomic, strong)NSArray <NSString *>*traffic;

@end


@interface RoomDetailDataModel : XbedModel

@property (nonatomic, strong)RoomDetailAdditionModel *addition;
@property (nonatomic, strong)RoomDetailBaseInfoModel *baseInfo;
@property (nonatomic, strong)RoomDetailCommentModel *comment;
@property (nonatomic, strong)NSNumber *curPrice;
@property (nonatomic, strong)NSNumber *totalPrice;
@property (nonatomic, strong)NSArray <PictureModel *>*naviPic;
@property (nonatomic, strong)NSArray <RoomDetailNearRoomsModel *>*nearRooms;
@property (nonatomic, strong)NSArray <PictureModel *>*pictures;
@property (nonatomic, strong)NSArray <NSString *>*provServ;
@property (nonatomic, strong)NSArray <RoomDetailRoomStatusModel *>*roomStatus;
@property (nonatomic, strong)NSArray <NSString *>*remind;
@property (nonatomic, strong)NSArray <NSString *>*tag;

@end

@interface RoomDetailRespModel : XbedRespModel

@property (nonatomic, strong)RoomDetailDataModel *data;

@end
