//
//  SubmitIdcardRequest.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequest.h"
#import "SubmitIdcardRequestModel.h"
#import "SubmitIdcardRespModel.h"

@interface SubmitIdcardRequest : XbedRequest

@property (nonatomic, strong)SubmitIdcardRequestModel *requestModel;
@property (nonatomic, strong)SubmitIdcardRespModel *respModel;

- (id)initWithRequestModel:(SubmitIdcardRequestModel *)model;

@end
