//
//  HotCityManager.h
//  xbed
//
//  Created by Leo.Chen on 16/10/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  热门城市数据持久化

#import <Foundation/Foundation.h>

@interface HotCityManager : NSObject

@property (nonatomic, strong)NSArray <NSString *>*citys;


+ (instancetype)getInstance;

@end
