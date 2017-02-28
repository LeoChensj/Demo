//
//  InvoiceReceiverViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "InvoiceReceiverViewModel.h"
#import "StringCheckUtil.h"
#import "AddInvoiceRequest.h"
#import "UpdateInvoiceRequest.h"
#import "DelInvoiceRequest.h"

@implementation InvoiceReceiverViewModel

- (void)setupSignal
{
    _signalArea = [RACSignal combineLatest:@[RACObserve(self, invoiceModel.provinceName), RACObserve(self, invoiceModel.cityName), RACObserve(self, invoiceModel.countyName)] reduce:^id(NSString *provinceName, NSString *cityName, NSString *countyName){
        
        return @(provinceName.length && cityName.length && cityName.length);
        
    }];
    
    
    _signalInvoice = [RACSignal combineLatest:@[RACObserve(self, invoiceModel.title), RACObserve(self, invoiceModel.realname), RACObserve(self, invoiceModel.phone), RACObserve(self, invoiceModel.province), RACObserve(self, invoiceModel.city), RACObserve(self, invoiceModel.county), RACObserve(self, invoiceModel.address)] reduce:^id(NSString *title, NSString *realname, NSString *phone, NSNumber *province, NSNumber *city, NSNumber *county, NSString *address){
        
        return @(title.length && realname.length && phone.length && province && city && county && address.length);
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandAddInvoice = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            if([StringCheckUtil validatePhone:ws.invoiceModel.phone])
            {
                [LoadingView show];
                AddInvoiceRequestModel *model = [[AddInvoiceRequestModel alloc] init];
                model.address = ws.invoiceModel.address;
                model.city = ws.invoiceModel.city;
                model.county = ws.invoiceModel.county;
                model.phone = ws.invoiceModel.phone;
                model.province = ws.invoiceModel.province;
                model.realname = ws.invoiceModel.realname;
                model.title = ws.invoiceModel.title;
                
                AddInvoiceRequest *request = [[AddInvoiceRequest alloc] initWithRequestModel:model];
                [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                    
                    AddInvoiceRespModel *respModel = [request responseModel];
                    
                    if(respModel.data.addressId)
                    {
                        //ws.invoiceData = [ws.invoiceData arrayByAddingObject:respModel.data];
                        [ws.invoiceData addObject:respModel.data];
                    }
                    
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
                [subscriber sendNext:@"请正确填写手机号码"];
                [subscriber sendCompleted];
            }
            
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    _commandDelInvoice = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            DelInvoiceRequestModel *model = [[DelInvoiceRequestModel alloc] init];
            model.addressId = ws.invoiceModel.addressId;
            
            DelInvoiceRequest *request = [[DelInvoiceRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                DelInvoiceRespModel *respModel = [request responseModel];
                
                if(respModel.data.boolValue)//删除成功
                {
                    for (NSInteger i=0;i<ws.invoiceData.count;i++)
                    {
                        if([ws.invoiceData[i].addressId isEqual:ws.invoiceModel.addressId])
                        {
                            [ws.invoiceData removeObjectAtIndex:i];
                            break;
                        }
                    }
                    
                    
//                    //假如删除的发票就是选择的发票
//                    DBManager *manager = [DBManager getInstance];
//                    if([manager.selectInvoice.addressId isEqualToNumber:ws.invoiceModel.addressId])
//                    {
//                        manager.selectInvoice = nil;
//                    }
                    
                    
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
    
    
    
    
    _commandUpdateInvoice = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            if([StringCheckUtil validatePhone:ws.invoiceModel.phone])
            {
                [LoadingView show];
                UpdateInvoiceRequestModel *model = [[UpdateInvoiceRequestModel alloc] init];
                model.address = ws.invoiceModel.address;
                model.addressId = ws.invoiceModel.addressId;
                model.city = ws.invoiceModel.city;
                model.county = ws.invoiceModel.county;
                model.phone = ws.invoiceModel.phone;
                model.province = ws.invoiceModel.province;
                model.realname = ws.invoiceModel.realname;
                model.title = ws.invoiceModel.title;
                
                UpdateInvoiceRequest *request = [[UpdateInvoiceRequest alloc] initWithRequestModel:model];
                [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                    
                    UpdateInvoiceRespModel *respModel = [request responseModel];
                    
                    if(respModel.data.addressId)//修改成功
                    {
                        for (NSInteger i=0;i<ws.invoiceData.count;i++)
                        {
                            if([ws.invoiceData[i].addressId isEqual:respModel.data.addressId])
                            {
                                [ws.invoiceData replaceObjectAtIndex:i withObject:respModel.data];
                                break;
                            }
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
            }
            else
            {
                [subscriber sendNext:@"请正确填写手机号码"];
                [subscriber sendCompleted];
            }
            
            
            return nil;
        }];
        
        return signal;
    }];
}



- (InvoiceModel *)invoiceModel
{
    if(_invoiceModel==nil)
    {
        _invoiceModel = [[InvoiceModel alloc] init];
    }
    
    return _invoiceModel;
}


@end
