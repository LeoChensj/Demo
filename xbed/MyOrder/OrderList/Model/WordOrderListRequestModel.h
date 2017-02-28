//
//  WordOrderListRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 2017/2/20.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//  获取口令订单

#import "XbedRequestModel.h"

@interface WordOrderListRequestModel : XbedRequestModel

@property (nonatomic, strong)NSString *command;
@property (nonatomic, strong)NSString *commandName;
@property (nonatomic, strong)NSString *commandPhone;

@end
