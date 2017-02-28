//
//  AddInvoiceRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"
#import "InvoiceRespModel.h"

@interface AddInvoiceRespModel : XbedRespModel

@property (nonatomic, strong)InvoiceModel *data;

@end
