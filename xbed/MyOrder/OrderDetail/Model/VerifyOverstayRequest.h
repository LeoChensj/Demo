//
//  VerifyOverstayRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "VerifyOverstayRequestModel.h"
#import "VerifyOverstayRespModel.h"

@interface VerifyOverstayRequest : XbedRequest

@property (nonatomic, strong)VerifyOverstayRequestModel *requestModel;
@property (nonatomic, strong)VerifyOverstayRespModel *respModel;

- (id)initWithRequestModel:(VerifyOverstayRequestModel *)model;

@end
