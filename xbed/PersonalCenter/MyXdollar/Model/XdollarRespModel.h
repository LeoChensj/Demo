//
//  XdollarRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface XdollarModel : XbedRespModel

@property (nonatomic, strong)NSNumber *id;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSDate *createdAt;
@property (nonatomic, strong)NSNumber *accrual;

@end

@interface XdollarDataModel : XbedRespModel

@property (nonatomic, strong)NSNumber *xdollarValue;
@property (nonatomic, strong)NSArray <NSString *>*rules;
@property (nonatomic, strong)NSArray <XdollarModel *>*content;
@property (nonatomic, strong)NSNumber *totalElements;

@end

@interface XdollarRespModel : XbedRespModel

@property (nonatomic, strong)XdollarDataModel *data;

@end
