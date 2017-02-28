//
//  RoomEvaluateViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "CheckinCleanRespModel.h"

@interface CleanEvaluateViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)CheckinCleanEvaluationModel *cleanEvaluationData;

@property (nonatomic, strong)NSNumber *starId;
@property (nonatomic, strong)NSArray <NSNumber *>*termIdList;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSArray <NSData *>*imageDatas;
@property (nonatomic, strong)NSArray <NSString *>*picPathList;


@property (nonatomic, strong, readonly)RACSignal *signalSubmit;
@property (nonatomic, strong, readonly)RACCommand *commandSubmit;

@end
