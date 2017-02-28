//
//  CheckoutRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  办理退房

#import "XbedRequestModel.h"

@interface CheckoutRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSNumber *roomId;

@end
