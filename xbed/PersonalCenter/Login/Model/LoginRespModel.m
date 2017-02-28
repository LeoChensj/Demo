//
//  LoginRespModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LoginRespModel.h"

@implementation LoginModel

- (instancetype)init
{
    if(self = [super init])
    {
        [[RACSignal combineLatest:@[RACObserve(self, faceRecognition), RACObserve(self, state)] reduce:^id(NSNumber *faceRecognition, NSNumber *state){
            
            return @(faceRecognition.boolValue || state.integerValue==2);
            
        }] subscribeNext:^(NSNumber *x) {
            
            self.isIdentity = x;
            
        }];
    }
    
    return self;
}

@end

@implementation LoginRespDataModel

+ (NSValueTransformer *)userJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:LoginModel.class];
}

@end

@implementation LoginRespModel

+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:LoginRespDataModel.class];
}

@end
