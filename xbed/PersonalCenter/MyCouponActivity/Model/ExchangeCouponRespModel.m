//
//  ExchangeCouponRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/11/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ExchangeCouponRespModel.h"

@implementation ExchangeCouponRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CouponCardModel.class];
}

@end
