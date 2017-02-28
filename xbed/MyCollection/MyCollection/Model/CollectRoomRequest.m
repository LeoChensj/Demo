//
//  CollectRoomRequest.m
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CollectRoomRequest.h"

@implementation CollectRoomRequest

- (id)initWithRequestModel:(CollectRoomRequestModel *)model
{
    if(self = [super init])
    {
        _requestModel = model;
    }
    
    return self;
}

- (LeoRequestMethod)requestMethod
{
    return LeoRequestMethodPost;
}

- (NSString *)requestUrl
{
    return [NSString stringWithFormat:@"%@/api/auth/user/collectRoom", URL_HOST];
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
        _respModel = [MTLJSONAdapter modelOfClass:[CollectRoomRespModel class] fromJSONDictionary:self.responseJSONObject error:nil];
    }
    
    return _respModel;
}

@end
