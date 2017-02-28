//
//  OrderPriceDetailViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "CheckinOrderInfoRespModel.h"

@interface OrderPriceDetailViewModel : XbedViewModel

@property (nonatomic, assign)NSInteger rentType;
@property (nonatomic, strong)CheckinOrderPayInfoModel *payInfo;
@property (nonatomic, strong)NSNumber *actualPrice;//应付金额，自己计算

@end
