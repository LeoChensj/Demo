//
//  SubmitInvoiceRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  开发票

#import "XbedRequestModel.h"

@interface SubmitInvoiceRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *addressId;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSArray <NSString *>*orderNos;

@end
