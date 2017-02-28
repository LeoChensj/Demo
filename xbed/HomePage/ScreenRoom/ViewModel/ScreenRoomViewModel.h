//
//  ScreenRoomViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "ScreenRoomRespModel.h"
#import "CollectRoomRequestModel.h"

@interface ScreenRoomViewModel : XbedViewModel

//data
@property (nonatomic, assign)NSInteger rentType;//0:短租  1:长租
@property (nonatomic, assign)BOOL isLocate;//NO:普通   YES：从定位点进来的
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSArray <NSArray <ScreenRoomTagModel *>*>*positionTags;
@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*typeTags;//所有户型标签
@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*bedTags;//所有床数标签
@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*characteristicTags;//所有特色标签
@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*sortTags;//所有排序标签

@property (nonatomic, strong)NSArray <NSString *>*cities;
@property (nonatomic, strong)NSNumber *start;
@property (nonatomic, strong)NSNumber *size;
@property (nonatomic, strong)NSNumber *totalElements;

@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;

@property (nonatomic, strong)ScreenRoomTagModel *position1;
@property (nonatomic, strong)ScreenRoomTagModel *position2;

@property (nonatomic, strong)NSNumber *minPrice;
@property (nonatomic, strong)NSNumber *maxPrice;
@property (nonatomic, strong)NSArray <NSString *>*type;//户型
@property (nonatomic, strong)ScreenRoomTagModel *bed;
@property (nonatomic, strong)NSArray <NSString *> *characteristic;//特色

@property (nonatomic, strong)ScreenRoomTagModel *sort;//排序

@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*selectScreenModel;//选中的标签

@property (nonatomic, strong)NSArray <ScreenRoomListModel *>*roomListData;


//signal & command
@property (nonatomic, strong, readonly)RACSignal *signalDate;//日期
@property (nonatomic, strong, readonly)RACSignal *signalPosition;//位置
@property (nonatomic, strong, readonly)RACSignal *signalCondition;//筛选
@property (nonatomic, strong, readonly)RACSignal *signalSort;//排序
@property (nonatomic, strong, readonly)RACSignal *signalScreen;
@property (nonatomic, strong, readonly)RACCommand *commandGetAllTagAndRoomList;
@property (nonatomic, strong, readonly)RACCommand *commandGetAllTag;
@property (nonatomic, strong, readonly)RACCommand *commandGetRoomList;
@property (nonatomic, strong, readonly)RACCommand *commandGetMoreRoomList;
@property (nonatomic, strong, readonly)RACCommand *commandCollection;




@end
