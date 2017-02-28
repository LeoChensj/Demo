//
//  CheckinOrderInfoRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "CheckinOrderInfoRequestModel.h"
#import "CheckinOrderInfoRespModel.h"

@interface CheckinOrderInfoRequest : XbedRequest

@property (nonatomic, strong)CheckinOrderInfoRequestModel *requestModel;
@property (nonatomic, strong)CheckinOrderInfoRespModel *respModel;

- (id)initWithRequestModel:(CheckinOrderInfoRequestModel *)model;

@end
