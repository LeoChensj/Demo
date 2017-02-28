//
//  MyCouponActivityViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MyCouponActivityViewModel.h"
#import "CouponCardListRequest.h"
#import "ExchangeCouponRequest.h"

@implementation MyCouponActivityViewModel

- (void)initProperty
{
    self.couponData = @[@[], @[]];
}

- (void)setupSignal
{
    _signalExchange = [RACSignal combineLatest:@[RACObserve(self, code)] reduce:^id(NSString *code){
        
        return @(code && code.length>0);
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            CouponCardListRequestModel *model = [[CouponCardListRequestModel alloc] init];
            CouponCardListRequest *request = [[CouponCardListRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CouponCardListRespModel *respModel = [request responseModel];
                
                NSArray <CouponCardModel *>*normals = respModel.data.normals;
                NSArray <CouponCardModel *>*disableds = respModel.data.disableds;
                
                if(normals==nil) normals = @[];
                if(disableds==nil) disableds = @[];
                
                ws.couponData = @[normals, disableds];
                
                
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
    
    
    
    
    _commandExchange = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            ExchangeCouponRequestModel *model = [[ExchangeCouponRequestModel alloc] init];
            model.code = ws.code;
            ExchangeCouponRequest *request = [[ExchangeCouponRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                ExchangeCouponRespModel *respModel = [request responseModel];
                
                NSArray <NSArray <CouponCardModel *>*>*couponData = ws.couponData;
                NSMutableArray <CouponCardModel *>*normals = [NSMutableArray arrayWithArray:couponData[0]];
                NSArray <CouponCardModel *>*disableds = couponData[1];
                [normals insertObject:respModel.data atIndex:0];
                
                ws.couponData = @[normals, disableds];
                
                
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
