//
//  PersonalCenterViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/7/6.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PersonalCenterViewModel.h"
#import "QiniuTokenRequest.h"
#import "LeoUploadQiniuManager.h"
#import "UpdateHeadImgRequest.h"
#import "TokenRequest.h"

@implementation PersonalCenterViewModel

- (void)setupCommand
{
    WS(ws);
    
    _commandRefreshLoginData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            TokenRequestModel *model = [[TokenRequestModel alloc] init];
            TokenRequest *request = [[TokenRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                TokenRespModel *respModel = [request responseModel];
                
                DBManager *manager = [DBManager getInstance];
                manager.isLogin = YES;
                manager.loginModel = respModel.data;
                
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
    
    
    _commandUpLoadHead = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            
            QiniuTokenRequestModel *tokenModel = [[QiniuTokenRequestModel alloc] init];
            QiniuTokenRequest *tokenRequest = [[QiniuTokenRequest alloc] initWithRequestModel:tokenModel];
            [tokenRequest startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                QiniuTokenRespModel *tokenRespModel = [request responseModel];
                
                [LeoUploadQiniuManager uploadData:ws.headData token:tokenRespModel.data isPrivate:NO paramet:nil success:^(id paramet, NSString *key, NSString *imageUrl) {
                    
                    UpdateHeadImgRequestModel *model = [[UpdateHeadImgRequestModel alloc] init];
                    model.headImage = imageUrl;
                    
                    UpdateHeadImgRequest *request = [[UpdateHeadImgRequest alloc] initWithRequestModel:model];
                    [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                        
                        LoginModel *loginModel = [DBManager getInstance].loginModel;
                        loginModel.headImg = imageUrl;
                        [DBManager getInstance].loginModel = loginModel;
                        
                        [LoadingView close];
                        [subscriber sendNext:nil];
                        [subscriber sendCompleted];
                        
                    } failure:^(__kindof LeoBaseRequest *request) {
                        
                        [LoadingView close];
                        [subscriber sendNext:@"上传头像失败"];
                        [subscriber sendCompleted];
                        
                    }];
                    
                } failure:^{
                    
                    [LoadingView close];
                    [subscriber sendNext:@"上传头像失败"];
                    [subscriber sendCompleted];
                    
                }];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                [LoadingView close];
                [subscriber sendNext:@"上传头像失败"];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
}

@end
