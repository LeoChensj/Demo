//
//  GetImgVerifyCodeRespModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface GetImgVerifyCodeDataModel : XbedRespModel

@property (nonatomic, strong)NSString *code;
@property (nonatomic, strong)NSString *imageVerifyCode;
@property (nonatomic, strong)NSString *verifyCode;

@end

@interface GetImgVerifyCodeRespModel : XbedRespModel

@property (nonatomic, strong)GetImgVerifyCodeDataModel *data;

@end
