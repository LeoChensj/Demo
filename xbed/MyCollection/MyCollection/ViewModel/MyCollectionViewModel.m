//
//  MyCollectionViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyCollectionViewModel.h"
#import "CollectRoomListRequest.h"
#import "CollectRoomRequest.h"

@implementation MyCollectionViewModel

- (void)initProperty
{
    self.page = @1;
    self.size = @10;
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetMyCollectionList = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.page = @1;
            CollectRoomListRequestModel *model = [[CollectRoomListRequestModel alloc] init];
            model.page = ws.page;
            model.size = ws.size;
            
            CollectRoomListRequest *request = [[CollectRoomListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CollectRoomListRespModel *respModel = [request responseModel];
                ws.roomListData = respModel.data.roomList;
                ws.totalElements = respModel.data.totalElements;
                
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
    
    
    
    _commandGetMoreMyCollectionList = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.page = [NSNumber numberWithInteger:ws.page.integerValue+1];
            CollectRoomListRequestModel *model = [[CollectRoomListRequestModel alloc] init];
            model.page = ws.page;
            model.size = ws.size;
            
            CollectRoomListRequest *request = [[CollectRoomListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CollectRoomListRespModel *respModel = [request responseModel];
                ws.roomListData = [ws.roomListData arrayByAddingObjectsFromArray:respModel.data.roomList];
                ws.totalElements = respModel.data.totalElements;
                
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                ws.page = [NSNumber numberWithInteger:ws.page.integerValue-1];
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    _commandCollection = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(CollectRoomRequestModel *input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            CollectRoomRequestModel *model = input;
            
            CollectRoomRequest *request = [[CollectRoomRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
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
    
    
}

@end
