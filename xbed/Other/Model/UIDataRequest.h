//
//  UIDataRequest.h
//  xbed
//
//  Created by Leo.Chen on 2017/1/13.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "UIDataRequestModel.h"
#import "UIDataRespModel.h"

@interface UIDataRequest : XbedRequest

@property (nonatomic, strong)UIDataRequestModel *requestModel;
@property (nonatomic, strong)UIDataRespModel *respModel;

- (id)initWithRequestModel:(UIDataRequestModel *)model;

@end
