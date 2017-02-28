//
//  CleanEvaluateSubmitRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface CleanEvaluateSubmitRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSNumber *starId;
@property (nonatomic, strong)NSArray <NSNumber *>*termIdList;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSArray <NSString *>*picPathList;

@end
