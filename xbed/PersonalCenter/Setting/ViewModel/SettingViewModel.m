//
//  SettingViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SettingViewModel.h"
#import "LogoutRequest.h"

@implementation SettingViewModel

- (void)setupSignal
{
    _signalLogoutHidden = [RACSignal combineLatest:@[RACObserve([DBManager getInstance], isLogin)] reduce:^id(NSNumber *isLogin){
        
        return @(!isLogin.boolValue);
        
    }];
}

- (void)setupCommand
{
    
    _commandLogout = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            LogoutRequestModel *model = [[LogoutRequestModel alloc] init];
            LogoutRequest *request = [[LogoutRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                
                
            }];
            
            
            DBManager *manager = [DBManager getInstance];
            manager.isLogin = NO;
            manager.token = nil;
            manager.loginModel = nil;
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            
            return nil;
        }];
        
        return signal;
    }];
    
}

@end
