//
//  localAreaModel.m
//  xbed
//
//  Created by Leo.Chen on 16/4/22.
//  Copyright © 2016年 liujialin125. All rights reserved.
//

#import "LocalAreaModel.h"

@implementation LocalCountyModel

@end

@implementation LocalCityModel

+ (NSValueTransformer *)childListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:LocalCountyModel.class];
}

@end

@implementation LocalProvinceModel

+ (NSValueTransformer *)childListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:LocalCityModel.class];
}

@end

@implementation LocalAreaModel

+ (NSValueTransformer *)areaJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:LocalProvinceModel.class];
}

@end
