//
//  LoginViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "GetVerifyCodeRequest.h"
#import "GetImgVerifyCodeRequest.h"

@interface LoginViewModel : XbedViewModel

@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *password;
@property (nonatomic, strong)NSString *isText;
@property (nonatomic, strong)NSString *vCode;//图片验证码唯一识别码
@property (nonatomic, strong)NSString *codeBase64;

@property (nonatomic, strong)NSNumber *getCodeFlag1;//短信验证码
@property (nonatomic, strong)NSNumber *getCodeFlag2;//语音验证码

@property (nonatomic, strong, readonly)RACSignal *signalPhone;
@property (nonatomic, strong, readonly)RACSignal *signalPhonePwd;
@property (nonatomic, strong, readonly)RACCommand *commandGetVerifyCode;
@property (nonatomic, strong, readonly)RACCommand *commandGetImgVerifyCode;
@property (nonatomic, strong, readonly)RACCommand *commandImgVerify;//验证图形验证码
@property (nonatomic, strong, readonly)RACCommand *commandLogin;

@end
