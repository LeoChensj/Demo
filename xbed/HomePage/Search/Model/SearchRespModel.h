//
//  SearchRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface SearchModel : XbedRespModel

@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *cname;
@property (nonatomic, strong)NSString *code;
@property (nonatomic, strong)NSNumber *dataType;
@property (nonatomic, strong)NSArray <NSString *>*fullCname;

@end

@interface SearchDataModel : XbedRespModel

@property (nonatomic, strong)NSArray <SearchModel *>*datalist;
@property (nonatomic, strong)NSString *title;

@end

@interface SearchRespModel : XbedRespModel

@property (nonatomic, strong)NSArray <SearchDataModel *>*data;

@end
