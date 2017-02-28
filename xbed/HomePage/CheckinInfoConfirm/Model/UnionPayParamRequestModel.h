//
//  UnionPayParamRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface UnionPayParamRequestModel : XbedRequestModel

@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSNumber *price;

@end