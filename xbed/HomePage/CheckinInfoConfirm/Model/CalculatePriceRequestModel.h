//
//  CalculatePriceRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface CalculatePriceRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSNumber *activityId;
@property (nonatomic, strong)NSString *cardCode;
@property (nonatomic, strong)NSString *beginDate;
@property (nonatomic, strong)NSString *endDate;
@property (nonatomic, strong)NSNumber *isOverStay;
@property (nonatomic, strong)NSNumber *flag;
@property (nonatomic, strong)NSNumber *rentType;

@end
