//
//  QueryCheckinPersonRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "QueryCheckinPersonRequestModel.h"
#import "QueryCheckinPersonRespModel.h"

@interface QueryCheckinPersonRequest : XbedRequest

@property (nonatomic, strong)QueryCheckinPersonRequestModel *requestModel;
@property (nonatomic, strong)QueryCheckinPersonRespModel *respModel;

- (id)initWithRequestModel:(QueryCheckinPersonRequestModel *)model;

@end
