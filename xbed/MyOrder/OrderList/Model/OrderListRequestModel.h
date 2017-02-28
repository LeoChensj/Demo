//
//  OrderListRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface OrderListRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *type;
@property (nonatomic, strong)NSNumber *page;
@property (nonatomic, strong)NSNumber *size;

@end
