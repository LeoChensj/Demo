//
//  CheckinCleanRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinCleanRespModel.h"

@implementation CheckinCleanTimeItemModel

@end

@implementation CheckinCleanTimeModel

+ (NSValueTransformer *)todayJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CheckinCleanTimeItemModel.class];
}
+ (NSValueTransformer *)tomorrowJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CheckinCleanTimeItemModel.class];
}

@end

@implementation CheckinCleanStarTermListModel

@end

@implementation CheckinCleanStarTermModel

+ (NSValueTransformer *)termListJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CheckinCleanStarTermListModel.class];
}

@end

@implementation CheckinCleanEvaluationModel

+ (NSValueTransformer *)cleanStarTermJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CheckinCleanStarTermModel.class];
}

@end

@implementation CheckinCleanDataModel

+ (NSValueTransformer *)cleanEvaluationJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CheckinCleanEvaluationModel.class];
}
+ (NSValueTransformer *)cleanTimeJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CheckinCleanTimeModel.class];
}

@end

@implementation CheckinCleanRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CheckinCleanDataModel.class];
}

@end
