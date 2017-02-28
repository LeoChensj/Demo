//
//  DelCheckinPersonRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "DelCheckinPersonRequestModel.h"
#import "DelCheckinPersonRespModel.h"

@interface DelCheckinPersonRequest : XbedRequest

@property (nonatomic, strong)DelCheckinPersonRequestModel *requestModel;
@property (nonatomic, strong)DelCheckinPersonRespModel *respModel;

- (id)initWithRequestModel:(DelCheckinPersonRequestModel *)model;

@end
