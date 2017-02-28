//
//  ClientIdRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/11/3.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "ClientIdRequestModel.h"
#import "ClientIdRespModel.h"

@interface ClientIdRequest : XbedRequest

@property (nonatomic, strong)ClientIdRequestModel *requestModel;
@property (nonatomic, strong)ClientIdRespModel *respModel;

- (id)initWithRequestModel:(ClientIdRequestModel *)model;

@end
