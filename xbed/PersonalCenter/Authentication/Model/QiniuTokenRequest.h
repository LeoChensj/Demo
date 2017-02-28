//
//  QiniuTokenRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "QiniuTokenRequestModel.h"
#import "QiniuTokenRespModel.h"

@interface QiniuTokenRequest : XbedRequest

@property (nonatomic, strong)QiniuTokenRequestModel *requestModel;
@property (nonatomic, strong)QiniuTokenRespModel *respModel;

- (id)initWithRequestModel:(QiniuTokenRequestModel *)model;

@end
