//
//  XbedRespModel.m
//  xclear
//
//  Created by Leo.Chen on 16/6/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@implementation XbedModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}

@end

@implementation XbedRespModel

@end

@implementation PictureModel

+ (NSValueTransformer *)filePathJSONTransformer
{
    return [MTLValueTransformer transformerUsingReversibleBlock:^NSString *(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        
        if(value && value.length)
            return [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", value, (NSInteger)MAIN_SCREEN_WIDTH*2];
        else
            return nil;
        
    }];
}

@end
