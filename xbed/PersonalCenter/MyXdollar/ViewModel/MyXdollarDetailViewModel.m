//
//  MyXdollarDetailViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyXdollarDetailViewModel.h"
#import "XdollarRequest.h"

@implementation MyXdollarDetailViewModel

- (void)setupCommand
{
    WS(ws);
    
    _commandGetMoreData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.page = [NSNumber numberWithInteger:ws.page.integerValue+1];
            XdollarRequestModel *model = [[XdollarRequestModel alloc] init];
            model.page = ws.page;
            model.size = ws.size;
            
            XdollarRequest *request = [[XdollarRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                XdollarRespModel *respModel = [request responseModel];
                ws.totalElements = respModel.data.totalElements;
                ws.xdollarListData = [ws.xdollarListData arrayByAddingObjectsFromArray:respModel.data.content];
                
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
}

@end
