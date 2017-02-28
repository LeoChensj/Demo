//
//  NetworkOpenDoorRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface NetworkOpenDoorRequestModel : XbedRequestModel

@property (nonatomic, strong)NSString *idCard;
@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSString *validVal;

@end
