//
//  ApplyCleanRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "ApplyCleanRequestModel.h"
#import "ApplyCleanRespModel.h"

@interface ApplyCleanRequest : XbedRequest

@property (nonatomic, strong)ApplyCleanRequestModel *requestModel;
@property (nonatomic, strong)ApplyCleanRespModel *respModel;

- (id)initWithRequestModel:(ApplyCleanRequestModel *)model;

@end
