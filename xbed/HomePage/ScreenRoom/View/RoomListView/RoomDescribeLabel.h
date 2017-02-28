//
//  RoomDescribeLabel.h
//  xbed
//
//  Created by Leo.Chen on 16/7/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  描述 subTitle  2室1厅1卫 | 可住7人 | 5.0分

#import <UIKit/UIKit.h>

@interface RoomDescribeLabel : UILabel

@property (nonatomic, strong)NSString *type;//户型
@property (nonatomic, strong)NSNumber *count;//可住人数
@property (nonatomic, strong)NSNumber *score;//评分

@end
