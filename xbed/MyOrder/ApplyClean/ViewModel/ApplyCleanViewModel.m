//
//  ApplyCleanViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ApplyCleanViewModel.h"
#import "ApplyCleanRequest.h"

@implementation ApplyCleanViewModel

- (void)setupSignal
{
    _signalSelectTime = [RACSignal combineLatest:@[RACObserve(self, selectTime)] reduce:^id(CheckinCleanTimeItemModel *selectTime){
        
        return @(selectTime && YES);
        
    }];
    
}

- (void)setupCommand
{
    WS(ws);
    
    _commandApplyClean = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            ApplyCleanRequestModel *model = [[ApplyCleanRequestModel alloc] init];
            model.checkinId = ws.checkinId;
            model.orderNo = ws.orderNo;
            model.roomId = ws.roomId;
            model.time = ws.selectTime.id;
            
            ApplyCleanRequest *request = [[ApplyCleanRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
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
    
    
}


@end
