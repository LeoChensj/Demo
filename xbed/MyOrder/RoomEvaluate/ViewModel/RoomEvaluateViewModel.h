//
//  RoomEvaluateViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "CheckinOrderInfoRespModel.h"
#import "TagModel.h"
#import "GetRoomEvaluateRespModel.h"
#import "NearbyRoomModel.h"
#import "OrderDetailViewModel.h"

@interface RoomEvaluateViewModel : XbedViewModel

@property (nonatomic, assign)BOOL flag;//提交成功后是否返回数据
@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSNumber *rentType;
@property (nonatomic, strong)CheckinOrderRoomInfoModel *roomInfo;


@property (nonatomic, strong)GetRoomEvaluateWaitEvaluateModel *waitEvaluateData;
@property (nonatomic, strong)GetRoomEvaluateEvaluatedModel *evaluatedData;
@property (nonatomic, strong)GetRoomEvaluateOverdueModel *overdueData;

@property (nonatomic, strong)NSArray <NearbyRoomModel *>*nearbyRoomData;

/*
 房间评价状态
 1  未评价
 2  已评价
 3  评价过期
 */
@property (nonatomic, strong)NSNumber *roomEvaluateState;


//用于提交评价的数据
@property (nonatomic, strong)NSNumber *subRoomStarId;
@property (nonatomic, strong)NSArray <NSNumber *>*subRoomTermIdList;
@property (nonatomic, strong)NSNumber *subCleanStarId;
@property (nonatomic, strong)NSArray <NSNumber *>*subCleanTermIdList;
@property (nonatomic, strong)NSString *subContent;
@property (nonatomic, strong)NSArray <NSData *>*subPicDataList;
@property (nonatomic, strong)NSArray <NSString *>*subPicPathList;

@property (nonatomic, strong)OrderDetailViewModel *orderDetailViewModel;



@property (nonatomic, strong, readonly)RACCommand *commandGetData;
@property (nonatomic, strong, readonly)RACCommand *commandSubmit;

@end
