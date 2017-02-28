//
//  LoginRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/8/31.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "LoginRequestModel.h"
#import "LoginRespModel.h"

@interface LoginRequest : XbedRequest

@property (nonatomic, strong)LoginRequestModel *requestModel;
@property (nonatomic, strong)LoginRespModel *respModel;

- (id)initWithRequestModel:(LoginRequestModel *)model;

@end
