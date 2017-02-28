//
//  RoomPricePointAnnotation.h
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "AroundRoomModel.h"

@interface RoomPricePointAnnotation : MAPointAnnotation

@property (nonatomic, strong)AroundRoomModel *model;

@end
