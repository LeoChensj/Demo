//
//  UpdateInvoiceRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "UpdateInvoiceRespModel.h"

@implementation UpdateInvoiceRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:InvoiceModel.class];
}

@end
