//
//  ApplyCleanViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "CheckinCleanRespModel.h"

@interface ApplyCleanViewModel : XbedViewModel

@property (nonatomic, strong)NSArray <CheckinCleanTimeItemModel *>*todayData;
@property (nonatomic, strong)NSArray <CheckinCleanTimeItemModel *>*tomorrowData;
@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSNumber *roomId;


@property (nonatomic, strong)CheckinCleanTimeItemModel *selectTime;


@property (nonatomic, strong, readonly)RACSignal *signalSelectTime;
@property (nonatomic, strong, readonly)RACCommand *commandApplyClean;

@end
