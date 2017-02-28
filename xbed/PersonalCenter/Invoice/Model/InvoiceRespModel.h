//
//  InvoiceRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface InvoiceModel : XbedModel

@property (nonatomic, strong)NSNumber *addressId;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *realname;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSNumber *province;
@property (nonatomic, strong)NSString *provinceName;
@property (nonatomic, strong)NSNumber *city;
@property (nonatomic, strong)NSString *cityName;
@property (nonatomic, strong)NSNumber *county;
@property (nonatomic, strong)NSString *countyName;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSNumber *flag;

@end


@interface InvoiceDataModel : XbedModel

//@property (nonatomic, strong)NSNumber *availMoney;
//@property (nonatomic, strong)NSNumber *freePostageMoney;
@property (nonatomic, strong)NSMutableArray <InvoiceModel *>*receivers;

@end

@interface InvoiceRespModel : XbedRespModel

@property (nonatomic, strong)InvoiceDataModel *data;

@end
