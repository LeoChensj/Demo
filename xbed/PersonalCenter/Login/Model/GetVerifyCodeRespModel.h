//
//  GetVerifyCodeRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface GetVerifyCodeDataModel : XbedRespModel

@property (nonatomic, strong)NSString *imageVerifyCode;
@property (nonatomic, strong)NSString *verifyCode;

@end

@interface GetVerifyCodeRespModel : XbedRespModel

@property (nonatomic, strong)GetVerifyCodeDataModel *data;

@end
