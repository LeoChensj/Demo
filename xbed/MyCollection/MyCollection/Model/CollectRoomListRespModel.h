//
//  CollectRoomListRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface CollectRoomListModel : XbedRespModel

@property (nonatomic, strong)NSNumber *rentType;
@property (nonatomic, strong)NSNumber *cleanGrade;
@property (nonatomic, strong)NSString *coverPic;
@property (nonatomic, strong)NSString *custRoomName;
@property (nonatomic, strong)NSNumber *flag;
@property (nonatomic, strong)NSNumber *hasFullView;
@property (nonatomic, strong)NSString *houseType;
@property (nonatomic, strong)NSNumber *liveCount;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSNumber *totalPrice;
@property (nonatomic, strong)NSNumber *roomGrade;
@property (nonatomic, strong)NSNumber *roomId;

@end

@interface CollectRoomListDataModel : XbedRespModel

@property (nonatomic, strong)NSArray <CollectRoomListModel *>*roomList;
@property (nonatomic, strong)NSNumber *totalElements;
@property (nonatomic, strong)NSNumber *totalPages;

@end

@interface CollectRoomListRespModel : XbedRespModel

@property (nonatomic, strong)CollectRoomListDataModel *data;

@end
