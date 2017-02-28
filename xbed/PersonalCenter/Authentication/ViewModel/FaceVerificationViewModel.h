//
//  FaceVerificationViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "FaceVerificationRequest.h"
#import "CanFaceVerificationRequest.h"

@interface FaceVerificationViewModel : XbedViewModel

@property (nonatomic, strong)LoginModel *loginModel;
@property (nonatomic, assign)BOOL canFaceVerify;

@property (nonatomic, strong, readonly)RACSignal *signalNextStep;
@property (nonatomic, strong, readonly)RACCommand *commandCanFaceVerification;

@end
