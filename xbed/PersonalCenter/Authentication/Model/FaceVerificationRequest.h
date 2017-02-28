//
//  FaceVerificationRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/11/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "FaceVerificationRequestModel.h"
#import "FaceVerificationRespModel.h"

@interface FaceVerificationRequest : XbedRequest

@property (nonatomic, strong)FaceVerificationRequestModel *requestModel;
@property (nonatomic, strong)FaceVerificationRespModel *respModel;

- (id)initWithRequestModel:(FaceVerificationRequestModel *)model;

@end
