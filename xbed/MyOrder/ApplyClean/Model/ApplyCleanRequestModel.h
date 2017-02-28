//
//  ApplyCleanRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/10/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface ApplyCleanRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSString *time;

@end
