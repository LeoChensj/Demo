//
//  CheckVersionRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "CheckVersionRequestModel.h"
#import "CheckVersionRespModel.h"

@interface CheckVersionRequest : XbedRequest

@property (nonatomic, strong)CheckVersionRequestModel *requestModel;
@property (nonatomic, strong)CheckVersionRespModel *respModel;

- (id)initWithRequestModel:(CheckVersionRequestModel *)model;

@end
