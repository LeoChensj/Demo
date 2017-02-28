//
//  WordOrderListRespModel.h
//  xbed
//
//  Created by Leo.Chen on 2017/2/20.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"
#import "OrderListRespModel.h"

@interface WordOrderListRespModel : XbedRespModel

@property (nonatomic, strong)OrderListDataModel *data;

@end
