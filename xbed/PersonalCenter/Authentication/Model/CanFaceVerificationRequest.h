//
//  CanFaceVerificationRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/11/3.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "CanFaceVerificationRequestModel.h"
#import "CanFaceVerificationRespModel.h"

@interface CanFaceVerificationRequest : XbedRequest

@property (nonatomic, strong)CanFaceVerificationRequestModel *requestModel;
@property (nonatomic, strong)CanFaceVerificationRespModel *respModel;

- (id)initWithRequestModel:(CanFaceVerificationRequestModel *)model;

@end
