//
//  UpdateCheckinPersonRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  暂时不用

#import "XbedRequest.h"
#import "UpdateCheckinPersonRequestModel.h"
#import "UpdateCheckinPersonRespModel.h"

@interface UpdateCheckinPersonRequest : XbedRequest

@property (nonatomic, strong)UpdateCheckinPersonRequestModel *requestModel;
@property (nonatomic, strong)UpdateCheckinPersonRespModel *respModel;

- (id)initWithRequestModel:(UpdateCheckinPersonRequestModel *)model;

@end
