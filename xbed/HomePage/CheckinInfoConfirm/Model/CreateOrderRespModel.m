//
//  CreateOrderRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CreateOrderRespModel.h"

@implementation CreateOrderDataModel

@end

@implementation CreateOrderRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CreateOrderDataModel.class];
}

@end
