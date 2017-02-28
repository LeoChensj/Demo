//
//  QueryCheckinPersonRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface QueryCheckinPersonRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *isPrivate;
@property (nonatomic, strong)NSString *phone;

@end
