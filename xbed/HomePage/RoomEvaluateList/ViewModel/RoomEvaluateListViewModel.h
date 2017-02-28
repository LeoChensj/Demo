//
//  RoomEvaluateListViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "RoomCommentListRespModel.h"

@interface RoomEvaluateListViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSNumber *evaluateNumber;
@property (nonatomic, strong)NSNumber *roomScore;
@property (nonatomic, strong)NSNumber *cleanScore;
@property (nonatomic, strong)NSNumber *score;//前端算

@property (nonatomic, strong)NSNumber *page;
@property (nonatomic, strong)NSNumber *size;
@property (nonatomic, strong)NSNumber *totalElements;

@property (nonatomic, strong)NSArray <RoomCommentListModel *>*evaluateData;


@property (nonatomic, strong, readonly)RACCommand *commendGetData;
@property (nonatomic, strong, readonly)RACCommand *commendGetMoreData;

@end
