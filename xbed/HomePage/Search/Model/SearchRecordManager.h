//
//  SearchHistoryRecordArray.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  搜索记录数据持久化

#import <Foundation/Foundation.h>

@interface SearchRecordModel : XbedModel

@property (nonatomic, strong)NSString *cname;
@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *positionCode;

@end



@interface SearchRecordManager : NSObject

@property (nonatomic, strong)NSMutableArray <SearchRecordModel *>*records;

+ (instancetype)getInstance;
- (void)addRecord:(SearchRecordModel *)record;
- (void)clear;

@end
