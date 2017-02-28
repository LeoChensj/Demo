//
//  SearchViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/7/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SearchViewModel.h"
#import "HotCityRequest.h"
#import "SearchRequest.h"
#import "HotCityManager.h"

@implementation SearchViewModel

- (void)setupSignal
{
    self.recordData = [SearchRecordManager getInstance].records;
    
    WS(ws);
    _signalInput = [RACSignal combineLatest:@[RACObserve(self, inputText)] reduce:^id(NSString *inputText){
        
        if(inputText.length==0)
        {
            ws.associateListData = nil;
        }
        
        if(inputText && inputText.length>0 && (ws.markedTextRange==nil || ws.markedTextRange.empty))
        {
            return inputText;
        }
        else
        {
            return nil;
        }
        
    }];
    
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetHotCityFromLocal = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.hotCityData = [HotCityManager getInstance].citys;
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    _commandGetHotCityFromNetwork = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            HotCityRequestModel *model = [[HotCityRequestModel alloc] init];
            
            HotCityRequest *request = [[HotCityRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                HotCityRespModel *respModel = [request responseModel];
                ws.hotCityData = respModel.data;
                
                //保存热门城市
                [HotCityManager getInstance].citys = respModel.data;
                
                
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

    
    
    //搜索联想
    _commandGetAssociateData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            SearchRequestModel *model = [[SearchRequestModel alloc] init];
            model.city = ws.city;
            model.keyword = ws.inputText;
            model.tagTypeName = @"room";
            
            SearchRequest *request = [[SearchRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                SearchRespModel *respModel = [request responseModel];
                ws.associateListData = respModel.data;
                
                
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
    
    
    _commandAddSearchRecord = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(SearchRecordModel *input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            SearchRecordManager *manager = [SearchRecordManager getInstance];
            [manager addRecord:input];
            ws.recordData = manager.records;
            
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    _commandClearSearchRecord = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(SearchRecordModel *input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            SearchRecordManager *manager = [SearchRecordManager getInstance];
            [manager clear];
            ws.recordData = manager.records;
            
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            
            return nil;
        }];
        
        return signal;
    }];
    
}

@end
