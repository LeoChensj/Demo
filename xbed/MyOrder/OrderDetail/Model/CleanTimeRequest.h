//
//  CleanTimeRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "CleanTimeRequestModel.h"
#import "CleanTimeRespModel.h"

@interface CleanTimeRequest : XbedRequest

@property (nonatomic, strong)CleanTimeRequestModel *requestModel;
@property (nonatomic, strong)CleanTimeRespModel *respModel;

- (id)initWithRequestModel:(CleanTimeRequestModel *)model;

@end
