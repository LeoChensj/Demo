//
//  RoomCommentListRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@interface RoomCommentListRequestModel : XbedRequestModel

@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSNumber *page;
@property (nonatomic, strong)NSNumber *size;

@end
