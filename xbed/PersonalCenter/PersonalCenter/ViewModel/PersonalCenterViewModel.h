//
//  PersonalCenterViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/7/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"

@interface PersonalCenterViewModel : XbedViewModel

@property (nonatomic, assign)BOOL isLogin;
@property (nonatomic, strong)LoginModel *loginModel;
@property (nonatomic, strong)NSData *headData;

@property (nonatomic, strong, readonly)RACCommand *commandRefreshLoginData;
@property (nonatomic, strong, readonly)RACCommand *commandUpLoadHead;

@end
