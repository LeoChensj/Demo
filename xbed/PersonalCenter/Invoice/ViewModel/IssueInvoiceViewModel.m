//
//  IssueInvoiceViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "IssueInvoiceViewModel.h"
#import "InvoiceRequest.h"
#import "SubmitInvoiceRequest.h"

@implementation IssueInvoiceViewModel

- (void)setupSignal
{
    _signalSubmit = [RACSignal combineLatest:@[RACObserve(self, money), RACObserve(self, selectInvoice)] reduce:^id(NSNumber *money, InvoiceModel *selectInvoice){
        
        return @(money.floatValue>0  && selectInvoice);
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            InvoiceRequestModel *model = [[InvoiceRequestModel alloc] init];
            InvoiceRequest *request = [[InvoiceRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                InvoiceRespModel *respModel = [request responseModel];
                
                ws.invoiceData = respModel.data.receivers;
                
                for(NSInteger i=0;i<respModel.data.receivers.count;i++)
                {
                    if(respModel.data.receivers[i].flag.boolValue)
                    {
                        ws.selectInvoice = respModel.data.receivers[i];
                        break;
                    }
                }
                
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
    
    
    
    _commandSubmit = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            if(ws.money.integerValue>=100)
            {
                [LoadingView show];
                SubmitInvoiceRequestModel *model = [[SubmitInvoiceRequestModel alloc] init];
                model.price = ws.money;
                model.addressId = ws.selectInvoice.addressId;
                
                NSMutableArray <NSString *>*mArr = [NSMutableArray array];
                for (NSInteger i=0;i<ws.selectOrder.count;i++)
                {
                    [mArr addObject:ws.selectOrder[i].checkinOrderList[0].orderNo];
                }
                model.orderNos = mArr;
                
                SubmitInvoiceRequest *request = [[SubmitInvoiceRequest alloc] initWithRequestModel:model];
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
            else
            {
                [subscriber sendNext:@"发票金额需大于1元"];
                [subscriber sendCompleted];
            }
            
            
            return nil;
        }];
        
        return signal;
    }];
    
    
}

@end
