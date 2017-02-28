//
//  CleanEvaluateSubmitRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "CleanEvaluateSubmitRequestModel.h"
#import "CleanEvaluateSubmitRespModel.h"

@interface CleanEvaluateSubmitRequest : XbedRequest

@property (nonatomic, strong)CleanEvaluateSubmitRequestModel *requestModel;
@property (nonatomic, strong)CleanEvaluateSubmitRespModel *respModel;

- (id)initWithRequestModel:(CleanEvaluateSubmitRequestModel *)model;

@end
