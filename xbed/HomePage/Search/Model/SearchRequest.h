//
//  SearchRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "SearchRequestModel.h"
#import "SearchRespModel.h"

@interface SearchRequest : XbedRequest

@property (nonatomic, strong)SearchRequestModel *requestModel;
@property (nonatomic, strong)SearchRespModel *respModel;

- (id)initWithRequestModel:(SearchRequestModel *)model;

@end
