//
//  FeedbackRequest.h
//  xbed
//
//  Created by Leo.Chen on 16/9/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "FeedbackRequestModel.h"
#import "FeedbackRespModel.h"

@interface FeedbackRequest : XbedRequest

@property (nonatomic, strong)FeedbackRequestModel *requestModel;
@property (nonatomic, strong)FeedbackRespModel *respModel;

- (id)initWithRequestModel:(FeedbackRequestModel *)model;

@end
