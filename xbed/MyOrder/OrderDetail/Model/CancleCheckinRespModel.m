//
//  CancleCheckinRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CancleCheckinRespModel.h"

@implementation CancleCheckinDataModel

@end

@implementation CancleCheckinRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CancleCheckinDataModel.class];
}

@end
