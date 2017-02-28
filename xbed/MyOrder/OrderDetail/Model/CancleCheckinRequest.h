//
//  CancleCheckinRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  取消入住单

#import "XbedRequest.h"
#import "CancleCheckinRequestModel.h"
#import "CancleCheckinRespModel.h"

@interface CancleCheckinRequest : XbedRequest

@property (nonatomic, strong)CancleCheckinRequestModel *requestModel;
@property (nonatomic, strong)CancleCheckinRespModel *respModel;

- (id)initWithRequestModel:(CancleCheckinRequestModel *)model;

@end
