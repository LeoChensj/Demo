//
//  ScreenRoomRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@class ScreenRoomTagModel;

@interface ScreenRoomListModel : XbedModel

@property (nonatomic, strong)NSNumber *rentType;
@property (nonatomic, strong)NSNumber *canBook;
@property (nonatomic, strong)NSNumber *cleanGrade;
@property (nonatomic, strong)NSNumber *collected;
@property (nonatomic, strong)NSString *coverPic;
@property (nonatomic, strong)NSString *descri;
@property (nonatomic, strong)NSNumber *hasFullView;
@property (nonatomic, strong)NSString *houseType;
@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSNumber *liveCount;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSNumber *totalPrice;
@property (nonatomic, strong)NSNumber *roomGrade;
@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSString *roomName;
@property (nonatomic, strong)NSNumber *distance;

@end

@interface ScreenRoomPositionModel : XbedModel

@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*area;
@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*building;
@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*businessCircle;

@end

@interface ScreenRoomTagModel : XbedModel

@property (nonatomic, strong)NSString *cname;
@property (nonatomic, strong)NSString *code;
@property (nonatomic, strong)NSNumber *type;

@end

@interface ScreenRoomDataModel : XbedModel

@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*bedCountTag;
@property (nonatomic, strong)NSArray <NSString *>*cities;
@property (nonatomic, strong)NSDate *currTime;
@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*houseTypeTag;
@property (nonatomic, strong)ScreenRoomPositionModel *position;
@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*roomFeatureTag;
@property (nonatomic, strong)NSArray <ScreenRoomListModel *>*roomList;
@property (nonatomic, strong)NSNumber *totalElements;
@property (nonatomic, strong)NSNumber *totalPages;

@end

@interface ScreenRoomRespModel : XbedRespModel

@property (nonatomic, strong)ScreenRoomDataModel *data;

@end
