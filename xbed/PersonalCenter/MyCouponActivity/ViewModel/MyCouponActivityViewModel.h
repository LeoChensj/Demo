//
//  MyCouponActivityViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "CouponCardListRespModel.h"

@interface MyCouponActivityViewModel : XbedViewModel

@property (nonatomic, strong)NSString *code;//兑换码
@property (nonatomic, strong)NSArray <NSArray <CouponCardModel *>*>*couponData;


@property (nonatomic, strong, readonly)RACSignal *signalExchange;
@property (nonatomic, strong, readonly)RACCommand *commandGetData;
@property (nonatomic, strong, readonly)RACCommand *commandExchange;

@end
