//
//  OrderListViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "OrderListRequest.h"

@interface OrderListViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *page0;
@property (nonatomic, strong)NSNumber *page1;
@property (nonatomic, strong)NSNumber *page2;
@property (nonatomic, strong)NSNumber *page3;
@property (nonatomic, strong)NSNumber *page4;
@property (nonatomic, strong)NSNumber *size;

@property (nonatomic, strong)NSNumber *totalElements0;
@property (nonatomic, strong)NSNumber *totalElements1;
@property (nonatomic, strong)NSNumber *totalElements2;
@property (nonatomic, strong)NSNumber *totalElements3;
@property (nonatomic, strong)NSNumber *totalElements4;

@property (nonatomic, strong)NSArray <OrderListContnetModel *>*orderData0;
@property (nonatomic, strong)NSArray <OrderListContnetModel *>*orderData1;
@property (nonatomic, strong)NSArray <OrderListContnetModel *>*orderData2;
@property (nonatomic, strong)NSArray <OrderListContnetModel *>*orderData3;
@property (nonatomic, strong)NSArray <OrderListContnetModel *>*orderData4;

@property (nonatomic, strong)NSNumber *orderType;//当前选中的orderType

@property (nonatomic, assign)BOOL isWord;
@property (nonatomic, strong)NSString *word;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *phone;

@property (nonatomic, strong, readonly)RACCommand *commandGetOrderData0;
@property (nonatomic, strong, readonly)RACCommand *commandGetOrderData1;
@property (nonatomic, strong, readonly)RACCommand *commandGetOrderData2;
@property (nonatomic, strong, readonly)RACCommand *commandGetOrderData3;
@property (nonatomic, strong, readonly)RACCommand *commandGetOrderData4;

@property (nonatomic, strong, readonly)RACCommand *commandGetMoreOrderData0;
@property (nonatomic, strong, readonly)RACCommand *commandGetMoreOrderData1;
@property (nonatomic, strong, readonly)RACCommand *commandGetMoreOrderData2;
@property (nonatomic, strong, readonly)RACCommand *commandGetMoreOrderData3;
@property (nonatomic, strong, readonly)RACCommand *commandGetMoreOrderData4;

@property (nonatomic, strong, readonly)RACCommand *commandGetWordOrderData;

@end
