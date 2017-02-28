//
//  InvoiceRecordRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface InvoiceRecordModel : XbedModel

@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *cityName;
@property (nonatomic, strong)NSString *countyName;
@property (nonatomic, strong)NSString *expressCompany;
@property (nonatomic, strong)NSString *expressNum;
@property (nonatomic, strong)NSNumber *id;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSNumber *postStatus;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSString *provinceName;
@property (nonatomic, strong)NSString *realname;
@property (nonatomic, strong)NSString *title;

@end

@interface InvoiceRecordDataModel : XbedRespModel

@property (nonatomic, strong)NSArray <InvoiceRecordModel *>*content;
@property (nonatomic, strong)NSNumber *totalPages;
@property (nonatomic, strong)NSNumber *totalElements;

@end

@interface InvoiceRecordRespModel : XbedRespModel

@property (nonatomic, strong)InvoiceRecordDataModel *data;

@end
