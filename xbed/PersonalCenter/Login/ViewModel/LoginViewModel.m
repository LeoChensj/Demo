//
//  LoginViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LoginViewModel.h"
#import "StringCheckUtil.h"
#import "LoginRequest.h"

@implementation LoginViewModel

- (void)setupSignal
{
    _signalPhone = [RACSignal combineLatest:@[RACObserve(self, phone)] reduce:^id(NSString *phone){
        
        return @(phone.length>0);
        
    }];
    
    _signalPhonePwd = [RACSignal combineLatest:@[RACObserve(self, phone), RACObserve(self, password)] reduce:^id(NSString *phone, NSString *password){
        
        return @(phone.length>0 && password.length>0);
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetVerifyCode = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            if([StringCheckUtil validatePhone:ws.phone])
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
                model.phone = ws.phone;
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
                [subscriber sendNext:@"请正确填写手机号码"];
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
            model.phone = ws.phone;
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
    
    
    
    //登录
    _commandLogin = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            if([StringCheckUtil validatePhone:ws.phone])
            {
                if([StringCheckUtil validateVcode:ws.password])
                {
                    [LoadingView show];
                    
                    LoginRequestModel *model = [[LoginRequestModel alloc] init];
                    model.phone = ws.phone;
                    model.password = ws.password;
                    model.source = @2;
                    
                    LoginRequest *request = [[LoginRequest alloc] initWithRequestModel:model];
                    [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                        
                        [LoadingView close];
                        
                        LoginRespModel *respModel = [request responseModel];
                        
                        DBManager *manager = [DBManager getInstance];
                        manager.isLogin = YES;
                        manager.token = respModel.data.token;
                        manager.loginModel = respModel.data.user;
                        
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
                [subscriber sendNext:@"请正确填写手机号码"];
                [subscriber sendCompleted];
            }
            
            
            return nil;
        }];
        
        return signal;
    }];
}

@end
