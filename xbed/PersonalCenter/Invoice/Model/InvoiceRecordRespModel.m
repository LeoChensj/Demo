//
//  InvoiceRecordRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceRecordRespModel.h"

@implementation InvoiceRecordModel

@end

@implementation InvoiceRecordDataModel

+ (NSValueTransformer *)contentJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:InvoiceRecordModel.class];
}

@end

@implementation InvoiceRecordRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:InvoiceRecordDataModel.class];
}

@end
