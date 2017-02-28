//
//  CheckinRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/10/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinRespModel.h"

@implementation CheckinDataModel

@end

@implementation CheckinRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CheckinDataModel.class];
}

@end
