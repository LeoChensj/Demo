//
//  ApplePayParamRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface ApplePayParamRequestModel : XbedRequestModel

@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSNumber *price;

@end
