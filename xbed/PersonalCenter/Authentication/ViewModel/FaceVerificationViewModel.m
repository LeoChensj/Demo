//
//  FaceVerificationViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "FaceVerificationViewModel.h"

@implementation FaceVerificationViewModel

- (void)setupSignal
{
    _signalNextStep = [RACSignal combineLatest:@[RACObserve(self, loginModel.name), RACObserve(self, loginModel.idNo)] reduce:^id(NSString *name, NSString *idNo){
        
        return @(name.length && idNo.length);
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandCanFaceVerification = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            if(ws.loginModel.idNo.length==18)
            {
                [LoadingView show];
                CanFaceVerificationRequestModel *model = [[CanFaceVerificationRequestModel alloc] init];
                CanFaceVerificationRequest *request = [[CanFaceVerificationRequest alloc] initWithRequestModel:model];
                [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                    
                    CanFaceVerificationRespModel *respModel = [request responseModel];
                    ws.canFaceVerify = respModel.data.boolValue;
                    
                    [LoadingView close];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                    
                } failure:^(__kindof LeoBaseRequest *request) {
                    
                    [LoadingView close];
                    [subscriber sendNext:[request getErrorMsg]];
                    [subscriber sendCompleted];
                    
                }];
            }
            else
            {
                [subscriber sendNext:@"请正确输入身份证号"];
                [subscriber sendCompleted];
            }
            
            
            return nil;
        }];
        
        return signal;
    }];
}

@end
