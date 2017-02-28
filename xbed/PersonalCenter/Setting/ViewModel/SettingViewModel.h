//
//  SettingViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"

@interface SettingViewModel : XbedViewModel

@property (nonatomic, strong, readonly)RACSignal *signalLogoutHidden;
@property (nonatomic, strong, readonly)RACCommand *commandLogout;

@end
