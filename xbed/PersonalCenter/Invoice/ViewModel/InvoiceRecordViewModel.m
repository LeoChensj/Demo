//
//  InvoiceRecordViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceRecordViewModel.h"
#import "InvoiceRecordRequest.h"

@implementation InvoiceRecordViewModel

- (void)initProperty
{
    self.page = @1;
    self.size = @15;
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetInvoiceRecord = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            InvoiceRecordRequestModel *model = [[InvoiceRecordRequestModel alloc] init];
            model.page = ws.page;
            model.size = ws.size;
            
            InvoiceRecordRequest *request = [[InvoiceRecordRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                InvoiceRecordRespModel *respModel = [request responseModel];
                
                ws.invoiceRecordData = respModel.data.content;
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
    
    
    _commandGetMoreInvoiceRecord = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.page = [NSNumber numberWithInteger:ws.page.integerValue+1];
            
            [LoadingView show];
            InvoiceRecordRequestModel *model = [[InvoiceRecordRequestModel alloc] init];
            model.page = ws.page;
            model.size = ws.size;
            
            InvoiceRecordRequest *request = [[InvoiceRecordRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                InvoiceRecordRespModel *respModel = [request responseModel];
                
                ws.invoiceRecordData = [ws.invoiceRecordData arrayByAddingObjectsFromArray:respModel.data.content];
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
