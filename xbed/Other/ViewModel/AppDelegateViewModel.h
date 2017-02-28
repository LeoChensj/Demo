//
//  AppDelegateViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"

@interface AppDelegateViewModel : XbedViewModel

@property (nonatomic, strong, readonly)RACCommand *commandCheckVersion;
@property (nonatomic, strong, readonly)RACCommand *commandLogin;
@property (nonatomic, strong, readonly)RACCommand *commandGetAdPageData;

@end
