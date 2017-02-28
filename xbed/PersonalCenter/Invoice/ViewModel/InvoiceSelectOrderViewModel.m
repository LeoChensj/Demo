//
//  InvoiceSelectOrderViewModel.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceSelectOrderViewModel.h"
#import "InvoiceOrderRequest.h"

@implementation InvoiceSelectOrderViewModel

- (void)initProperty
{
    self.page = @1;
    self.size = @10;
}

- (void)setupSignal
{
    _signalNext = [RACSignal combineLatest:@[RACObserve(self, selectOrder), RACObserve(self, invoicePrice)] reduce:^id(NSArray <OrderListContnetModel *>*selectOrder, NSNumber *invoicePrice){
        
        return @(selectOrder.count && invoicePrice.floatValue>0);
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetOrderList = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            
            ws.page = @1;
            
            InvoiceOrderRequestModel *model = [[InvoiceOrderRequestModel alloc] init];
            model.page = ws.page;
            model.size = ws.size;
            InvoiceOrderRequest *request = [[InvoiceOrderRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                InvoiceOrderRespModel *respModel = [request responseModel];
                ws.orderData = respModel.data.contents;
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
    
    
    _commandGetMoreOrderList = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.page = [NSNumber numberWithInteger:ws.page.integerValue+1];
            
            InvoiceOrderRequestModel *model = [[InvoiceOrderRequestModel alloc] init];
            model.page = ws.page;
            model.size = ws.size;
            InvoiceOrderRequest *request = [[InvoiceOrderRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                InvoiceOrderRespModel *respModel = [request responseModel];
                ws.orderData = [ws.orderData arrayByAddingObjectsFromArray:respModel.data.contents];
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
