//
//  CreateOrderRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface CreateOrderRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSString *beginDate;
@property (nonatomic, strong)NSString *endDate;
@property (nonatomic, strong)NSNumber *discount;
@property (nonatomic, strong)NSNumber *activityId;
@property (nonatomic, strong)NSString *cardCode;
@property (nonatomic, strong)NSNumber *xdollar;
@property (nonatomic, strong)NSNumber *bargainMoney;
@property (nonatomic, strong)NSNumber *rentType;

@property (nonatomic, strong)NSString *command;
@property (nonatomic, strong)NSString *commandName;
@property (nonatomic, strong)NSString *commandPhone;

@end
