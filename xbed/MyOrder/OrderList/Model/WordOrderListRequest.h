//
//  WordOrderListRequest.h
//  xbed
//
//  Created by Leo.Chen on 2017/2/20.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "WordOrderListRequestModel.h"
#import "WordOrderListRespModel.h"

@interface WordOrderListRequest : XbedRequest

@property (nonatomic, strong)WordOrderListRequestModel *requestModel;
@property (nonatomic, strong)WordOrderListRespModel *respModel;

- (id)initWithRequestModel:(WordOrderListRequestModel *)model;

@end
