//
//  CardVerificationViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "QueryCheckinPersonRespModel.h"

@interface CardVerificationViewModel : XbedViewModel

@property (nonatomic, strong)QueryCheckinPersonDataModel *checkinPersonData;

@property (nonatomic, strong)NSData *imageData1;

@property (nonatomic, strong, readonly)RACSignal *signalSave;
@property (nonatomic, strong, readonly)RACCommand *commandGetCheckinInfo;
//@property (nonatomic, strong, readonly)RACCommand *commandUploadQiniu;
@property (nonatomic, strong, readonly)RACCommand *commandSave;

@end
