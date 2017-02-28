//
//  ScreenRoomRequestModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenRoomRequestModel.h"

@implementation ScreenRoomTimeModel

@end

@implementation ScreenRoomPriceModel

@end

@implementation ScreenRoomScreeningModel

- (ScreenRoomPriceModel *)price
{
    if(_price==nil)
    {
        _price = [[ScreenRoomPriceModel alloc] init];
    }
    
    return _price;
}

@end

@implementation ScreenRoomQueryModel

- (ScreenRoomScreeningModel *)screening
{
    if(_screening==nil)
    {
        _screening = [[ScreenRoomScreeningModel alloc] init];
    }
    
    return _screening;
}

- (ScreenRoomTimeModel *)time
{
    if(_time==nil)
    {
        _time = [[ScreenRoomTimeModel alloc] init];
    }
    
    return _time;
}

@end

@implementation ScreenRoomRequestModel

- (ScreenRoomQueryModel *)query
{
    if(_query==nil)
    {
        _query = [[ScreenRoomQueryModel alloc] init];
    }
    
    return _query;
}

@end
