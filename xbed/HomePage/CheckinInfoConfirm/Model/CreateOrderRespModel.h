//
//  CreateOrderRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface CreateOrderDataModel : XbedModel

@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSNumber *checkinId;

@end

@interface CreateOrderRespModel : XbedRespModel

@property (nonatomic, strong)CreateOrderDataModel *data;

@end
