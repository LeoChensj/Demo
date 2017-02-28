//
//  HomeMainRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "HomeMainRequestModel.h"
#import "HomeMainRespModel.h"

@interface HomeMainRequest : XbedRequest

@property (nonatomic, strong)HomeMainRequestModel *requestModel;
@property (nonatomic, strong)HomeMainRespModel *respModel;

- (id)initWithRequestModel:(HomeMainRequestModel *)model;

@end
