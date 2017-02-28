//
//  AddInvoiceRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface AddInvoiceRequestModel : XbedRequestModel

@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSNumber *city;
@property (nonatomic, strong)NSString *code;
@property (nonatomic, strong)NSNumber *county;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSNumber *province;
@property (nonatomic, strong)NSString *realname;
@property (nonatomic, strong)NSString *title;

@end
