//
//  QueryCheckinPersonRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "QueryCheckinPersonRespModel.h"

@implementation QueryCheckinPersonDataModel

@end

@implementation QueryCheckinPersonRespModel

+ (NSValueTransformer *)DataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:QueryCheckinPersonDataModel.class];
}

@end
