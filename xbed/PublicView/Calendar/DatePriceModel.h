//
//  DatePriceModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatePriceModel : NSObject

@property (nonatomic, strong)NSDate *date;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, assign)NSInteger state;//0表示不可订，1表示可订

@end
