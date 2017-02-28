//
//  CalculatePriceRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface CouponCardModel : XbedModel

@property (nonatomic, strong)NSDate *beginTimestamp;
@property (nonatomic, strong)NSString *code;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic, strong)NSDate *endTimestamp;
@property (nonatomic, strong)NSNumber *leastCost;
@property (nonatomic, strong)NSString *otherUse;
@property (nonatomic, strong)NSString *title;

@end

@interface couponCardDataModel : XbedModel

@property (nonatomic, strong)NSArray <CouponCardModel *>*normals;
@property (nonatomic, strong)NSArray <CouponCardModel *>*disableds;

@end

@interface ActivityContentsModel : XbedModel

@property (nonatomic, strong)NSNumber *activityId;
@property (nonatomic, strong)NSString *describes;
@property (nonatomic, strong)NSNumber *discount;
@property (nonatomic, strong)NSNumber *integral;
@property (nonatomic, strong)NSNumber *isDefault;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSNumber *totalPrice;

@end

@interface CalculatePriceDataModel : XbedModel

@property (nonatomic, strong)NSArray <ActivityContentsModel *>*contents;
@property (nonatomic, strong)couponCardDataModel *couponCard;
@property (nonatomic, strong)NSNumber *discount;
@property (nonatomic, strong)NSNumber *flag;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSNumber *xdollar;
@property (nonatomic, strong)NSNumber *bargainMoney;

@end

@interface CalculatePriceRespModel : XbedRespModel

@property (nonatomic, strong)CalculatePriceDataModel *data;

@end
