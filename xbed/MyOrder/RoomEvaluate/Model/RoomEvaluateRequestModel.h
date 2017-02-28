//
//  RoomEvaluateRequestModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  房间评价

#import "XbedRequestModel.h"

@interface RoomEvaluateRequestModel : XbedRequestModel

@property (nonatomic, assign)BOOL flag;
@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSNumber *cleanStarId;
@property (nonatomic, strong)NSArray <NSNumber *>*cleanTermIdList;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSArray <NSString *>*picPathList;
@property (nonatomic, strong)NSNumber *roomStarId;
@property (nonatomic, strong)NSArray <NSNumber *>*roomTermIdList;

@end
