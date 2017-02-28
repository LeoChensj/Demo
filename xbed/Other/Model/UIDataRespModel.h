//
//  UIDataRespModel.h
//  xbed
//
//  Created by Leo.Chen on 2017/1/13.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface UIDataDataModel : XbedRespModel

@property (nonatomic, strong)NSString *appStartPage;
@property (nonatomic, strong)NSString *loginPage;
@property (nonatomic, strong)NSString *checkinConfirmRemind;
@property (nonatomic, strong)NSString *orderRetainTime;
@property (nonatomic, strong)NSString *serviceTelephone;
@property (nonatomic, strong)NSString *passwordText;

@end

@interface UIDataRespModel : XbedRespModel

@property (nonatomic, strong)UIDataDataModel *data;

@end
