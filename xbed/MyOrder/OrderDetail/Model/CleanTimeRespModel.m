//
//  CleanTimeRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CleanTimeRespModel.h"

@implementation CleanTimeRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CheckinCleanTimeModel.class];
}

@end
