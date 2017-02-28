//
//  RoomEvaluateViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/10/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CleanEvaluateViewModel.h"
#import "QiniuTokenRequest.h"
#import "LeoUploadQiniuManager.h"
#import "CleanEvaluateSubmitRequest.h"

@implementation CleanEvaluateViewModel

- (void)setupSignal
{
    _signalSubmit = [RACSignal combineLatest:@[RACObserve(self, starId)] reduce:^id(NSNumber *starId){
        
        return @(starId && YES);
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandSubmit = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            if(ws.imageDatas==nil || ws.imageDatas.count<=0)//不需要上传图片
            {
                [LoadingView show];
                CleanEvaluateSubmitRequestModel *model = [[CleanEvaluateSubmitRequestModel alloc] init];
                model.checkinId = ws.checkinId;
                model.orderNo = ws.orderNo;
                model.roomId = ws.roomId;
                model.starId = ws.starId;
                if(ws.termIdList && ws.termIdList.count)
                {
                    model.termIdList = ws.termIdList;
                }
                model.content = ws.content;
                
                CleanEvaluateSubmitRequest *request = [[CleanEvaluateSubmitRequest alloc] initWithRequestModel:model];
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
            else//需要上传图片
            {
                [LoadingView show];
                QiniuTokenRequestModel *tokenModel = [[QiniuTokenRequestModel alloc] init];
                QiniuTokenRequest *tokenRequest = [[QiniuTokenRequest alloc] initWithRequestModel:tokenModel];
                [tokenRequest startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                    
                    QiniuTokenRespModel *tokenRespModel = [request responseModel];
                    
                    //异步上传七牛
                    ws.picPathList = @[];
                    for (NSInteger i=0;i<ws.imageDatas.count;i++)
                    {
                        [LeoUploadQiniuManager uploadData:ws.imageDatas[i] token:tokenRespModel.data isPrivate:NO paramet:nil success:^(id paramet, NSString *key, NSString *imageUrl) {
                            
                            if(imageUrl.length>0)
                            {
                                ws.picPathList = [ws.picPathList arrayByAddingObject:imageUrl];
                            }
                            
                        } failure:^{
                            
                            [LoadingView close];
                            [subscriber sendNext:@"评论失败"];
                            [subscriber sendCompleted];
                            
                        }];
                    }
                    
                    
                    [RACObserve(ws, picPathList) subscribeNext:^(NSArray <NSString *>*x) {
                        
                        if(x.count>=ws.imageDatas.count)//图片全部上传Qiniu完成
                        {
                            NSLog(@"上传Qiniu完成");
                            
                            CleanEvaluateSubmitRequestModel *model = [[CleanEvaluateSubmitRequestModel alloc] init];
                            model.checkinId = ws.checkinId;
                            model.orderNo = ws.orderNo;
                            model.roomId = ws.roomId;
                            model.starId = ws.starId;
                            if(ws.termIdList && ws.termIdList.count)
                            {
                                model.termIdList = ws.termIdList;
                            }
                            model.content = ws.content;
                            model.picPathList = ws.picPathList;
                            
                            CleanEvaluateSubmitRequest *request = [[CleanEvaluateSubmitRequest alloc] initWithRequestModel:model];
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
                        
                    }];
                    
                    
                } failure:^(__kindof LeoBaseRequest *request) {
                    
                    [LoadingView close];
                    [subscriber sendNext:@"评论失败"];
                    [subscriber sendCompleted];
                    
                }];
                
                
                
            }
            
            
            return nil;
        }];
        
        return signal;
    }];
}

@end
