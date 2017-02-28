//
//  InvoiceOrderRespModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"
#import "OrderListRespModel.h"

@interface InvoiceOrderRespModel : XbedRespModel

@property (nonatomic, strong)OrderListDataModel *data;

@end
