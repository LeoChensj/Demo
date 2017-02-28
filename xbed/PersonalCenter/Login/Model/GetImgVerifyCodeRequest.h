//
//  GetImgVerifyCodeRequest.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "GetImgVerifyCodeRequestModel.h"
#import "GetImgVerifyCodeRespModel.h"

@interface GetImgVerifyCodeRequest : XbedRequest

@property (nonatomic, strong)GetImgVerifyCodeRequestModel *requestModel;
@property (nonatomic, strong)GetImgVerifyCodeRespModel *respModel;

- (id)initWithRequestModel:(GetImgVerifyCodeRequestModel *)model;

@end
