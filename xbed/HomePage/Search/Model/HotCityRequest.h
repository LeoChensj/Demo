//
//  HotCityRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "HotCityRequestModel.h"
#import "HotCityRespModel.h"

@interface HotCityRequest : XbedRequest

@property (nonatomic, strong)HotCityRequestModel *requestModel;
@property (nonatomic, strong)HotCityRespModel *respModel;

- (id)initWithRequestModel:(HotCityRequestModel *)model;

@end
