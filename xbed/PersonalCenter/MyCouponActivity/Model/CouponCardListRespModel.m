//
//  CouponCardListRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/10/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CouponCardListRespModel.h"

@implementation CouponCardListDataModel

+ (NSValueTransformer *)normalsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CouponCardModel.class];
}

+ (NSValueTransformer *)disabledsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:CouponCardModel.class];
}

@end

@implementation CouponCardListRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CouponCardListDataModel.class];
}

@end
