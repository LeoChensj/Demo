//
//  ApplePayParamRespModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface ApplePayParamDataModel : XbedRespModel

@property (nonatomic, strong)NSString *payTN;

@end

@interface ApplePayParamRespModel : XbedRespModel

@property (nonatomic, strong)ApplePayParamDataModel *data;

@end
