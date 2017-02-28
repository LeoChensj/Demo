//
//  NetworkOpenDoorViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "NetworkOpenDoorViewModel.h"
#import "GetVerifyCodeRequest.h"
#import "NetworkOpenDoorRequest.h"

@implementation NetworkOpenDoorViewModel

- (void)setupSignal
{
    _signalCardId = [RACSignal combineLatest:@[RACObserve(self, cardId)] reduce:^id(NSString *cardId){
        
        return @(cardId && cardId.length>0);
        
    }];
    
    _signalCardIdPwd = [RACSignal combineLatest:@[RACObserve(self, cardId), RACObserve(self, password)] reduce:^id(NSString *cardId, NSString *password){
        
        return @(cardId && cardId.length>0 && password && password.length>0);
        
    }];
    
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetVerifyCode = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            if(ws.cardId && ws.cardId.length==6)
            {
                if([ws.isText isEqualToString:@"true"])
                {
                    ws.getCodeFlag1 = @1;
                }
                else if([ws.isText isEqualToString:@"false"])
                {
                    ws.getCodeFlag2 = @1;
                }
                
                GetVerifyCodeRequestModel *model = [[GetVerifyCodeRequestModel alloc] init];
                model.phone = [DBManager getInstance].loginModel.phone;
                model.isText = ws.isText;
                
                GetVerifyCodeRequest *request = [[GetVerifyCodeRequest alloc] initWithRequestModel:model];
                [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                    
                    GetVerifyCodeRespModel *respModel = [request responseModel];
                    
                    if(respModel.data && respModel.data.verifyCode.length && respModel.data.imageVerifyCode.length)
                    {
                        if([ws.isText isEqualToString:@"true"])
                        {
                            ws.getCodeFlag1 = @3;
                        }
                        else if([ws.isText isEqualToString:@"false"])
                        {
                            ws.getCodeFlag2 = @3;
                        }
                        
                        ws.vCode = respModel.data.verifyCode;
                        ws.codeBase64 = respModel.data.imageVerifyCode;
                        
                        [subscriber sendNext:@"imageCode"];
                        [subscriber sendCompleted];
                    }
                    else
                    {
                        if([ws.isText isEqualToString:@"true"])
                        {
                            ws.getCodeFlag1 = @2;
                        }
                        else if([ws.isText isEqualToString:@"false"])
                        {
                            ws.getCodeFlag2 = @2;
                        }
                        
                        [subscriber sendNext:nil];
                        [subscriber sendCompleted];
                    }
                    
                } failure:^(__kindof LeoBaseRequest *request) {
                    
                    if([ws.isText isEqualToString:@"true"])
                    {
                        ws.getCodeFlag1 = @3;
                    }
                    else if([ws.isText isEqualToString:@"false"])
                    {
                        ws.getCodeFlag2 = @3;
                    }
                    
                    [subscriber sendNext:[request getErrorMsg]];
                    [subscriber sendCompleted];
                    
                }];
            }
            else
            {
                [subscriber sendNext:@"请正确填写身份证后6位"];
                [subscriber sendCompleted];
            }
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    //验证图形验证码
    _commandImgVerify = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            GetVerifyCodeRequestModel *model = [[GetVerifyCodeRequestModel alloc] init];
            model.phone = [DBManager getInstance].loginModel.phone;
            model.isText = ws.isText;
            model.imgCode = input;
            model.verifyCode = ws.vCode;
            
            GetVerifyCodeRequest *request = [[GetVerifyCodeRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                if([ws.isText isEqualToString:@"true"])
                {
                    ws.getCodeFlag1 = @2;
                }
                else if([ws.isText isEqualToString:@"false"])
                {
                    ws.getCodeFlag2 = @2;
                }
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    _commandGetImgVerifyCode = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            GetImgVerifyCodeRequestModel *model = [[GetImgVerifyCodeRequestModel alloc] init];
            GetImgVerifyCodeRequest *request = [[GetImgVerifyCodeRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                GetImgVerifyCodeRespModel *respModel = [request responseModel];
                ws.codeBase64 = respModel.data.imageVerifyCode;
                ws.vCode = respModel.data.verifyCode;
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    
    _commandOpenDoor = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            if(ws.cardId && ws.cardId.length==6)
            {
                if(ws.password && ws.password.length==4)
                {
                    [LoadingView show];
                    NetworkOpenDoorRequestModel *model = [[NetworkOpenDoorRequestModel alloc] init];
                    model.roomId = ws.roomId;
                    model.idCard = ws.cardId;
                    model.validVal = ws.password;
                    
                    NetworkOpenDoorRequest *request = [[NetworkOpenDoorRequest alloc] initWithRequestModel:model];
                    [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                        
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
                    [subscriber sendNext:@"请正确填写验证码"];
                    [subscriber sendCompleted];
                }
            }
            else
            {
                [subscriber sendNext:@"请正确填写身份证后6位"];
                [subscriber sendCompleted];
            }
            
            return nil;
        }];
        
        return signal;
    }];
}

@end
