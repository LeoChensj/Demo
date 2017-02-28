//
//  UnionPayParamRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface UnionPayParamDataModel : XbedRespModel

@property (nonatomic, strong)NSString *orderId;
@property (nonatomic, strong)NSString *payTN;//银行交易流水号
@property (nonatomic, strong)NSString *txnTime;

@end

@interface UnionPayParamRespModel : XbedRespModel

@property (nonatomic, strong)UnionPayParamDataModel *data;

@end
