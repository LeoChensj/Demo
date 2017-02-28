//
//  LogoutRequest.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "LogoutRequestModel.h"
#import "LogoutRespModel.h"

@interface LogoutRequest : XbedRequest

@property (nonatomic, strong)LogoutRequestModel *requestModel;
@property (nonatomic, strong)LogoutRespModel *respModel;

- (id)initWithRequestModel:(LogoutRequestModel *)model;

@end
