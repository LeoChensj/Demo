//
//  CheckVersionRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckVersionRespModel.h"

@implementation CheckVersionDataModel

@end

@implementation CheckVersionRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CheckVersionDataModel.class];
}

@end
