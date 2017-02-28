//
//  ExchangeCouponRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/11/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"
#import "CouponCardListRespModel.h"

@interface ExchangeCouponRespModel : XbedRespModel

@property (nonatomic, strong)CouponCardModel *data;

@end
