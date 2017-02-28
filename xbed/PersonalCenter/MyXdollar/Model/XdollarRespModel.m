//
//  XdollarRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/1.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XdollarRespModel.h"

@implementation XdollarModel

+ (NSValueTransformer *)createdAtJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSDate *(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:value.unsignedLongLongValue*0.001+8*3600];
        return [CalendarHandle dateHandle2:date];
        
    }];
}

@end

@implementation XdollarDataModel

//+ (NSValueTransformer *)rulesJSONTransformer 这种数组不需要转
//{
//    return [MTLJSONAdapter arrayTransformerWithModelClass:NSString.class];
//}

+ (NSValueTransformer *)contentJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:XdollarModel.class];
}

@end

@implementation XdollarRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:XdollarDataModel.class];
}

@end
