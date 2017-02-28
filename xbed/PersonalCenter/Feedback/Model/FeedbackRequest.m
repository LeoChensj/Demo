//
//  FeedbackRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/9/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "FeedbackRequest.h"

@implementation FeedbackRequest

- (id)initWithRequestModel:(FeedbackRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/auth/addFeedback", URL_HOST];
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return [_requestModel headerParam];
}

- (id)requestParam
{
    return [_requestModel requestParam];
}

- (id)responseModel
{
    if(self.responseJSONObject)
    {
        _respModel = [MTLJSONAdapter modelOfClass:[FeedbackRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
