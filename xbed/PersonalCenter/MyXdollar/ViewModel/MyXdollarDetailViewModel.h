//
//  MyXdollarDetailViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "XdollarRespModel.h"

@interface MyXdollarDetailViewModel : XbedViewModel

@property (nonatomic, strong)NSNumber *page;
@property (nonatomic, strong)NSNumber *size;
@property (nonatomic, strong)NSArray <XdollarModel *>*xdollarListData;
@property (nonatomic, strong)NSNumber *totalElements;

@property (nonatomic, strong, readonly)RACCommand *commandGetMoreData;

@end
