//
//  CheckinRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  办理入住

#import "XbedRequest.h"
#import "CheckinRequestModel.h"
#import "CheckinRespModel.h"

@interface CheckinRequest : XbedRequest

@property (nonatomic, strong)CheckinRequestModel *requestModel;
@property (nonatomic, strong)CheckinRespModel *respModel;

- (id)initWithRequestModel:(CheckinRequestModel *)model;

@end
