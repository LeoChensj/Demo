//
//  CollectRoomRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface CollectRoomRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *rentType;
@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSNumber *type;

@end
