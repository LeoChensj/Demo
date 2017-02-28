//
//  OrderListViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderListViewModel.h"
#import "CalendarHandle.h"
#import "WordOrderListRequest.h"

@implementation OrderListViewModel

- (void)initProperty
{
    self.page0 = @1;
    self.page1 = @1;
    self.page2 = @1;
    self.page3 = @1;
    self.page4 = @1;
    self.size = @10;
}

- (void)setupSignal
{
    
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetOrderData0 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            ws.page0 = @1;
            
            OrderListRequestModel *model = [[OrderListRequestModel alloc] init];
            model.type = @0;
            model.page = ws.page0;
            model.size = ws.size;
            
            WS(ws);
            OrderListRequest *request = [[OrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                OrderListRespModel *respModel = [request responseModel];
                
                ws.orderData0 = respModel.data.contents;
                ws.totalElements0 = respModel.data.totalElements;
                
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
    _commandGetOrderData0.allowsConcurrentExecution = YES;//重要，可重复执行
    
    _commandGetOrderData1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            

            ws.page1 = @1;
            
            OrderListRequestModel *model = [[OrderListRequestModel alloc] init];
            model.type = @1;
            model.page = ws.page1;
            model.size = ws.size;
            
            WS(ws);
            OrderListRequest *request = [[OrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                OrderListRespModel *respModel = [request responseModel];
                
                ws.orderData1 = respModel.data.contents;
                ws.totalElements1 = respModel.data.totalElements;
                
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
    _commandGetOrderData1.allowsConcurrentExecution = YES;//重要，可重复执行
    
    _commandGetOrderData2 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.page2 = @1;
            
            OrderListRequestModel *model = [[OrderListRequestModel alloc] init];
            model.type = @2;
            model.page = ws.page2;
            model.size = ws.size;
            
            WS(ws);
            OrderListRequest *request = [[OrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                OrderListRespModel *respModel = [request responseModel];
                
                ws.orderData2 = respModel.data.contents;
                ws.totalElements2 = respModel.data.totalElements;
                
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
    _commandGetOrderData2.allowsConcurrentExecution = YES;//重要，可重复执行
    
    _commandGetOrderData3 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            

            ws.page3 = @1;
            
            OrderListRequestModel *model = [[OrderListRequestModel alloc] init];
            model.type = @3;
            model.page = ws.page3;
            model.size = ws.size;
            
            WS(ws);
            OrderListRequest *request = [[OrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                OrderListRespModel *respModel = [request responseModel];
                
                ws.orderData3 = respModel.data.contents;
                ws.totalElements3 = respModel.data.totalElements;
                
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
    _commandGetOrderData3.allowsConcurrentExecution = YES;//重要，可重复执行
    
    _commandGetOrderData4 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            

            ws.page4 = @1;
            
            OrderListRequestModel *model = [[OrderListRequestModel alloc] init];
            model.type = @4;
            model.page = ws.page4;
            model.size = ws.size;
            
            WS(ws);
            OrderListRequest *request = [[OrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                OrderListRespModel *respModel = [request responseModel];
                
                ws.orderData4 = respModel.data.contents;
                ws.totalElements4 = respModel.data.totalElements;
                
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
    _commandGetOrderData4.allowsConcurrentExecution = YES;//重要，可重复执行
    
    
    
    
    
    
    
    
    
    
    _commandGetMoreOrderData0 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            OrderListRequestModel *model = [[OrderListRequestModel alloc] init];
            ws.page0 = [NSNumber numberWithInteger:ws.page0.integerValue+1];
            model.page = ws.page0;
            model.type = @0;
            model.size = ws.size;
            
            OrderListRequest *request = [[OrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                OrderListRespModel *respModel = [request responseModel];
                
                ws.orderData0 = [ws.orderData0 arrayByAddingObjectsFromArray:respModel.data.contents];
                ws.totalElements0 = respModel.data.totalElements;
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                ws.page0 = [NSNumber numberWithInteger:ws.page0.integerValue-1];
                
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    _commandGetMoreOrderData1 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            OrderListRequestModel *model = [[OrderListRequestModel alloc] init];
            ws.page1 = [NSNumber numberWithInteger:ws.page1.integerValue+1];
            model.page = ws.page1;
            model.type = @1;
            model.size = ws.size;
            
            OrderListRequest *request = [[OrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                OrderListRespModel *respModel = [request responseModel];
                
                ws.orderData1 = [ws.orderData1 arrayByAddingObjectsFromArray:respModel.data.contents];
                ws.totalElements1 = respModel.data.totalElements;
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                ws.page1 = [NSNumber numberWithInteger:ws.page1.integerValue-1];
                
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    _commandGetMoreOrderData2 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            OrderListRequestModel *model = [[OrderListRequestModel alloc] init];
            ws.page2 = [NSNumber numberWithInteger:ws.page2.integerValue+1];
            model.page = ws.page2;
            model.type = @2;
            model.size = ws.size;
            
            OrderListRequest *request = [[OrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                OrderListRespModel *respModel = [request responseModel];
                
                ws.orderData2 = [ws.orderData2 arrayByAddingObjectsFromArray:respModel.data.contents];
                ws.totalElements2 = respModel.data.totalElements;
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                ws.page2 = [NSNumber numberWithInteger:ws.page2.integerValue-1];
                
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    _commandGetMoreOrderData3 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            OrderListRequestModel *model = [[OrderListRequestModel alloc] init];
            ws.page3 = [NSNumber numberWithInteger:ws.page3.integerValue+1];
            model.page = ws.page3;
            model.type = @3;
            model.size = ws.size;
            
            OrderListRequest *request = [[OrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                OrderListRespModel *respModel = [request responseModel];
                
                ws.orderData3 = [ws.orderData3 arrayByAddingObjectsFromArray:respModel.data.contents];
                ws.totalElements3 = respModel.data.totalElements;
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                ws.page3 = [NSNumber numberWithInteger:ws.page3.integerValue-1];
                
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    _commandGetMoreOrderData4 = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            OrderListRequestModel *model = [[OrderListRequestModel alloc] init];
            ws.page4 = [NSNumber numberWithInteger:ws.page4.integerValue+1];
            model.page = ws.page4;
            model.type = @4;
            model.size = ws.size;
            
            OrderListRequest *request = [[OrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                OrderListRespModel *respModel = [request responseModel];
                
                ws.orderData4 = [ws.orderData4 arrayByAddingObjectsFromArray:respModel.data.contents];
                ws.totalElements4 = respModel.data.totalElements;
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                ws.page4 = [NSNumber numberWithInteger:ws.page4.integerValue-1];
                
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    _commandGetWordOrderData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            WordOrderListRequestModel *model = [[WordOrderListRequestModel alloc] init];
            model.command = ws.word;
            
            if(ws.name.length)
            {
                model.commandName = ws.name;
            }
            
            if(ws.phone.length)
            {
                model.commandPhone = ws.phone;
            }
            
            WordOrderListRequest *request = [[WordOrderListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                WordOrderListRespModel *respModel = [request responseModel];
                
                ws.orderData0 = respModel.data.contents;
                ws.totalElements0 = respModel.data.totalElements;
                
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
