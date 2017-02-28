//
//  TokenRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "TokenRequestModel.h"
#import "TokenRespModel.h"

@interface TokenRequest : XbedRequest

@property (nonatomic, strong)TokenRequestModel *requestModel;
@property (nonatomic, strong)TokenRespModel *respModel;

- (id)initWithRequestModel:(TokenRequestModel *)model;

@end
