//
//  RoomPricePointAnnotation.m
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomPricePointAnnotation.h"

@implementation RoomPricePointAnnotation

- (void)setModel:(AroundRoomModel *)model
{
    _model = model;
    
    self.coordinate = CLLocationCoordinate2DMake(model.latitude.floatValue, model.longitude.floatValue);
}

@end
