//
//  LoginRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface LoginModel : XbedModel

@property (nonatomic, strong)NSString *headImg;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSNumber *xdollarValue;
@property (nonatomic, strong)NSNumber *couponActivityCount;
@property (nonatomic, strong)NSNumber *isIdentity;//是否身份验证通过
@property (nonatomic, strong)NSNumber *faceRecognition;
@property (nonatomic, strong)NSNumber *idRecognition;
@property (nonatomic, strong)NSNumber *state;//1- 待审核, 2 - 审核通过, 3 - 审核不通过
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *idNo;
@property (nonatomic, strong)NSString *idImage;//身份证正面照
@property (nonatomic, strong)NSString *holdImage;//手持身份证正面照

@end

@interface LoginRespDataModel : XbedModel

@property (nonatomic, strong)NSString *token;
@property (nonatomic, strong)LoginModel *user;

@end

@interface LoginRespModel : XbedRespModel

@property (nonatomic, strong)LoginRespDataModel *data;

@end
