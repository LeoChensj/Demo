//
//  GetVerifyCodeRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface GetVerifyCodeRequestModel : XbedRequestModel

@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *isText;
@property (nonatomic, strong)NSString *imgCode;
@property (nonatomic, strong)NSString *verifyCode;

@end
