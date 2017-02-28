//
//  RoomDetailViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/3.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "NearbyRoomModel.h"
#import "RoomDetailRespModel.h"

@interface RoomDetailViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, assign)NSInteger rentType;//0:短租  1:长租

@property (nonatomic, strong)NSArray <NSString *>*roomImages;
@property (nonatomic, strong)NSNumber *price;//单位分
@property (nonatomic, strong)NSNumber *collection;//是否收藏
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *roomDesci;
@property (nonatomic, strong)NSArray <NSString *>*characteristicTags;
@property (nonatomic, strong)NSString *roomArea;
@property (nonatomic, strong)NSString *roomType;
@property (nonatomic, strong)NSNumber *floor;
@property (nonatomic, strong)NSString *roomNo;
@property (nonatomic, strong)NSNumber *person;
@property (nonatomic, strong)NSString *bedDesc;
@property (nonatomic, strong)NSArray <NSString *>*remind;//特别提醒

//日历数据
@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSArray <RoomDetailRoomStatusModel *>*roomStatus;

@property (nonatomic, strong)NSNumber *roomScore;
@property (nonatomic, strong)NSNumber *cleanScore;
@property (nonatomic, strong)NSNumber *score;//前端算
@property (nonatomic, strong)NSNumber *commentNo;
@property (nonatomic, strong)NSString *commentContent;

@property (nonatomic, strong)NSString *addressDetail;
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSArray <NSString *>*parkInfo;//停车信息
@property (nonatomic, strong)NSString *imageNavigation;//小区导航图

@property (nonatomic, strong)NSArray <NSString *>*serviceData;
@property (nonatomic, strong)NSArray <NSString *>*checkinNotice;//入住须知
@property (nonatomic, strong)NSArray <NSString *>*roomCharacter;
@property (nonatomic, strong)NSArray <NearbyRoomModel *>*nearbyRoom;



@property (nonatomic, strong, readonly)RACCommand *commandGetRoomDetailData;
@property (nonatomic, strong, readonly)RACCommand *commandCollection;

@end
