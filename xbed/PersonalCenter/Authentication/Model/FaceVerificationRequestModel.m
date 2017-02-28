//
//  FaceVerificationRequestModel.m
//  xbed
//
//  Created by Leo.Chen on 16/11/2.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "FaceVerificationRequestModel.h"

@implementation FaceVerificationRequestDataModel

@end

@implementation FaceVerificationRequestModel

//重要
- (void)setData:(NSArray<FaceVerificationRequestDataModel *> *)data
{
    _data = [MTLJSONAdapter JSONArrayFromModels:data error:nil];
}

@end
