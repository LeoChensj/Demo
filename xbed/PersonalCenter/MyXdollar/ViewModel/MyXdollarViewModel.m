//
//  MyXdollarViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyXdollarViewModel.h"
#import "XdollarRequest.h"

@implementation MyXdollarViewModel

- (void)initProperty
{
    self.page = @1;
    self.size = @15;
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetXdollarData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            XdollarRequestModel *model = [[XdollarRequestModel alloc] init];
            model.page = ws.page;
            model.size = ws.size;
            
            XdollarRequest *request = [[XdollarRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                XdollarRespModel *respModel = [request responseModel];
                
                ws.xdollar = respModel.data.xdollarValue;
                ws.rules = respModel.data.rules;
                ws.xdollarListData = respModel.data.content;
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
}

@end
