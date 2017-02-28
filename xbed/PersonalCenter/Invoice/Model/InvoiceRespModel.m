//
//  InvoiceRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceRespModel.h"

@implementation InvoiceModel

@end

@implementation InvoiceDataModel

+ (NSValueTransformer *)receiversJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:InvoiceModel.class];
}

@end

@implementation InvoiceRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:InvoiceDataModel.class];
}

@end
