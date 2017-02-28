//
//  UpdateHeadImgRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/10/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "UpdateHeadImgRequestModel.h"
#import "UpdateHeadImgRespModel.h"

@interface UpdateHeadImgRequest : XbedRequest

@property (nonatomic, strong)UpdateHeadImgRequestModel *requestModel;
@property (nonatomic, strong)UpdateHeadImgRespModel *respModel;

- (id)initWithRequestModel:(UpdateHeadImgRequestModel *)model;

@end
