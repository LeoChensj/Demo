//
//  MyXdollarViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "XdollarRespModel.h"

@interface MyXdollarViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *xdollar;
@property (nonatomic, strong)NSArray <NSString *>*rules;
@property (nonatomic, strong)NSNumber *page;
@property (nonatomic, strong)NSNumber *size;
@property (nonatomic, strong)NSArray <XdollarModel *>*xdollarListData;
@property (nonatomic, strong)NSNumber *totalElements;

@property (nonatomic, strong, readonly)RACCommand *commandGetXdollarData;

@end
