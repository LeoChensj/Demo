//
//  GetVerifyCodeRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/8/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "GetVerifyCodeRequestModel.h"
#import "GetVerifyCodeRespModel.h"

@interface GetVerifyCodeRequest : XbedRequest

@property (nonatomic, strong)GetVerifyCodeRequestModel *requestModel;
@property (nonatomic, strong)GetVerifyCodeRespModel *respModel;

- (id)initWithRequestModel:(GetVerifyCodeRequestModel *)model;

@end
