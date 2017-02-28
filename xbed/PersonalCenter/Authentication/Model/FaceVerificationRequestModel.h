//
//  FaceVerificationRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/11/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  人脸识别

#import "XbedRequestModel.h"

@interface FaceVerificationRequestDataModel : XbedModel

@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *code;

@end

@interface FaceVerificationRequestModel : XbedRequestModel

@property (nonatomic, strong)NSArray <FaceVerificationRequestDataModel *>*data;
@property (nonatomic, strong)NSString *idNo;
@property (nonatomic, strong)NSString *name;

@end
