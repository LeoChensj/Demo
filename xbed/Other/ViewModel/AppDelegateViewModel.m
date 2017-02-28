//
//  AppDelegateViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/10/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "AppDelegateViewModel.h"
#import "CheckVersionRequest.h"
#import "TokenRequest.h"
#import "UIDataRequest.h"

@implementation AppDelegateViewModel


- (void)setupCommand
{
//    WS(ws);
    
    _commandCheckVersion = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            CheckVersionRequestModel *model = [[CheckVersionRequestModel alloc] init];
            model.channel = @2;
            model.macAddress = [DBManager getInstance].uuid;
            model.systemName = @"Xbed";
            model.type = @2;
            model.versionNo = [DBManager getInstance].version;
            CheckVersionRequest *request = [[CheckVersionRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CheckVersionRespModel *respModel = [request responseModel];
                
                if(respModel.data)//存在最新版
                {
                    [subscriber sendNext:[NSNumber numberWithInteger:respModel.data.upgrade.integerValue+1]];
                    [subscriber sendCompleted];
                }
                else//不存在最新版
                {
                    [subscriber sendNext:@0];
                    [subscriber sendCompleted];
                }
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                //NSLog(@"版本检测失败");
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            }];
            
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    
    _commandLogin = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            DBManager *manager = [DBManager getInstance];
            if(manager.token && manager.token.length && manager.isLogin==NO)
            {
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
                    
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                    
                }];
            }
            else
            {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    _commandGetAdPageData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            UIDataRequestModel *model = [[UIDataRequestModel alloc] init];
            UIDataRequest *request = [[UIDataRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                UIDataRespModel *respModel = [request responseModel];
                

                [DBManager getInstance].appUITextData = respModel.data;
                
                
                NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
                NSString *filePath = [cachesPath stringByAppendingPathComponent:@"adPagePic.plist"];
                
                if(respModel.data.appStartPage.length)
                {
                    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:respModel.data.appStartPage] options:SDWebImageRefreshCached progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        
                        if(image)
                        {
                            [LeoFileManager saveData:image toFilePath:filePath];
                        }
                        
                        
                    }];
                }
                else
                {
                    [LeoFileManager saveData:nil toFilePath:filePath];
                }
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
}

@end
