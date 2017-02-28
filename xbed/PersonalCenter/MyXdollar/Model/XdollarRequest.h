//
//  XdollarRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "XdollarRequestModel.h"
#import "XdollarRespModel.h"

@interface XdollarRequest : XbedRequest

@property (nonatomic, strong)XdollarRequestModel *requestModel;
@property (nonatomic, strong)XdollarRespModel *respModel;

- (id)initWithRequestModel:(XdollarRequestModel *)model;

@end
