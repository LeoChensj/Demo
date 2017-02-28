//
//  InvoiceOrderRespModel.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceOrderRespModel.h"

@implementation InvoiceOrderRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:OrderListDataModel.class];
}

@end
