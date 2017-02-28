//
//  ScreenRoomRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface ScreenRoomTimeModel : XbedModel

@property (nonatomic, strong)NSString *end;
@property (nonatomic, strong)NSString *start;

@end

@interface ScreenRoomPriceModel : XbedModel

@property (nonatomic, strong)NSNumber *maxPrice;
@property (nonatomic, strong)NSNumber *minPrice;

@end

@interface ScreenRoomScreeningModel : XbedModel

@property (nonatomic, strong)NSNumber *bedCount;
@property (nonatomic, strong)NSArray <NSString *>*houseType;
@property (nonatomic, strong)NSArray <NSString *>*indiviTag;
@property (nonatomic, strong)ScreenRoomPriceModel *price;

@end

@interface ScreenRoomQueryModel : XbedModel

@property (nonatomic, strong)NSString *position;
@property (nonatomic, strong)ScreenRoomScreeningModel *screening;
@property (nonatomic, strong)ScreenRoomTimeModel *time;

@end

@interface ScreenRoomRequestModel : XbedRequestModel

@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *coordinate;
@property (nonatomic, strong)NSNumber *flag;
@property (nonatomic, strong)NSNumber *orderBy;
@property (nonatomic, strong)ScreenRoomQueryModel *query;
@property (nonatomic, strong)NSNumber *rentType;
@property (nonatomic, strong)NSNumber *size;
@property (nonatomic, strong)NSNumber *start;

@end
