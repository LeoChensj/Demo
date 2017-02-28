//
//  RoomEvaluateListViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluateListViewModel.h"
#import "RoomCommentListRequest.h"

@implementation RoomEvaluateListViewModel

- (void)initProperty
{
    self.page = @1;
    self.size = @10;
}

- (void)setupSignal
{
    WS(ws);
    [[RACSignal combineLatest:@[RACObserve(self, roomScore), RACObserve(self, cleanScore)] reduce:^id(NSNumber *roomScore, NSNumber *cleanScore){
        
        return @(roomScore && cleanScore);
        
    }] subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            ws.score = [NSNumber numberWithFloat:(ws.roomScore.floatValue+ws.cleanScore.floatValue)*0.5];
        }
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commendGetData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            
            ws.page = @1;
            RoomCommentListRequestModel *model = [[RoomCommentListRequestModel alloc] init];
            model.roomId = ws.roomId;
            model.page = ws.page;
            model.size = ws.size;
            RoomCommentListRequest *request = [[RoomCommentListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                RoomCommentListRespModel *respModel = [request responseModel];
                ws.evaluateData = respModel.data.commentList;
                ws.totalElements = respModel.data.totalElements;
                
                [LoadingView close];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                [LoadingView close];
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    
    
    _commendGetMoreData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            
            ws.page = [NSNumber numberWithInteger:ws.page.integerValue+1];
            RoomCommentListRequestModel *model = [[RoomCommentListRequestModel alloc] init];
            model.roomId = ws.roomId;
            model.page = ws.page;
            model.size = ws.size;
            RoomCommentListRequest *request = [[RoomCommentListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                RoomCommentListRespModel *respModel = [request responseModel];
                ws.evaluateData = [ws.evaluateData arrayByAddingObjectsFromArray:respModel.data.commentList];
                ws.totalElements = respModel.data.totalElements;
                
                [LoadingView close];
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                ws.page = [NSNumber numberWithInteger:ws.page.integerValue-1];
                
                [LoadingView close];
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
}

@end
