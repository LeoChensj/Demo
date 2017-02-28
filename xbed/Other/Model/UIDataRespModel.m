//
//  UIDataRespModel.m
//  xbed
//
//  Created by Leo.Chen on 2017/1/13.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "UIDataRespModel.h"

@implementation UIDataDataModel

@end

@implementation UIDataRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:UIDataDataModel.class];
}

@end
