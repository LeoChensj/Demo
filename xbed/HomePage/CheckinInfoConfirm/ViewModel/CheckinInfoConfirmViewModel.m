//
//  CheckinInfoConfirmViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CheckinInfoConfirmViewModel.h"
#import "RoomStatusRequest.h"
#import "CalculatePriceRequest.h"
#import "CreateOrderRequest.h"
#import "WechatPayParamRequest.h"
#import "UnionPayParamRequest.h"
#import "CreateOverstayOrderRequest.h"
#import "ApplePayParamRequest.h"
#import "StringCheckUtil.h"

@implementation CheckinInfoConfirmViewModel

- (void)setupSignal
{
    _signalDate = [RACSignal combineLatest:@[RACObserve(self, checkinDate), RACObserve(self, checkoutDate)] reduce:^id(NSDate *checkin, NSDate *checkout){
        
        return @(checkin && checkout && [checkin isLessDate:checkout]);
        
    }];
    
    _signalActivityCoupon = [RACSignal combineLatest:@[RACObserve(self, activityCouponFlag), RACObserve(self, selectCoupon), RACObserve(self, selectActivity)] reduce:^id(NSNumber *activityCouponFlag, CouponCardModel *selectCoupon, ActivityContentsModel *selectActivity){
        
        return @(activityCouponFlag && (selectActivity || selectCoupon));
        
    }];
    
    _signalEnablePay = [RACSignal combineLatest:@[_signalDate, RACObserve(self, actualMoney), RACObserve(self, isWord), RACObserve(self, word), RACObserve(self, name), RACObserve(self, phone)] reduce:^id(NSNumber *signalDate, NSNumber *actualMoney, NSNumber *isWord, NSString *word, NSString *name, NSString *phone){
        
        return @(signalDate.boolValue && actualMoney && (isWord.boolValue==NO || (isWord.boolValue && (word.length && (name.length || phone.length)))));
        
    }];
    
    
    
    WS(ws);
    //前端计算实际支付价格
    [[RACSignal combineLatest:@[RACObserve(self, deposit), RACObserve(self, totalMoney), RACObserve(self, discountMoney)] reduce:^id(NSNumber *deposit, NSNumber *totalMoney, NSNumber *discountMoney){
        
        if(ws.rentType==0)//短租
        {
            return @(totalMoney && discountMoney);
        }
        else//长租
        {
            return @(deposit && totalMoney && discountMoney);
        }
        
    }] subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            if(ws.rentType==0)//短租
            {
                NSInteger actualPrice = ws.totalMoney.integerValue-ws.discountMoney.integerValue;
                ws.actualMoney = [NSNumber numberWithInteger:actualPrice];
            }
            else//长租
            {
                NSInteger actualPrice = ws.deposit.integerValue+ws.totalMoney.integerValue-ws.discountMoney.integerValue;
                ws.actualMoney = [NSNumber numberWithInteger:actualPrice];
            }
            
        }
        
    }];
    
    [RACObserve(self, xdollarFlag) subscribeNext:^(NSNumber *x) {
        
        if(x)
        {
            if(x.boolValue)
            {
                ws.discountMoney = [NSNumber numberWithInteger:ws.discountMoneyNoXdollar.integerValue+ws.xdollarEnable.integerValue];
            }
            else
            {
                ws.discountMoney = ws.discountMoneyNoXdollar;
            }
        }
    }];
    
}

- (void)setupCommand
{
    WS(ws);
    
    //获取日历数据
    _commendGetCalendarData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            RoomStatusRequestModel *model = [[RoomStatusRequestModel alloc] init];
            model.roomId = ws.roomId;
            
            RoomStatusRequest *request = [[RoomStatusRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                RoomStatusRespModel *respModel = [request responseModel];
                ws.roomStatus = respModel.data;
                
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
    
    
    //获取订单数据、计算价格
    _commendGetOrderData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            //清空orderNo checkinId 重要
            ws.orderNo = nil;
            ws.checkinId = nil;
            
            
            
            [LoadingView show];
            CalculatePriceRequestModel *model = [[CalculatePriceRequestModel alloc] init];
            model.roomId = ws.roomId;
            model.beginDate = [NSDate stringFromDate:ws.checkinDate withFormat:@"yyyy-MM-dd"];
            model.endDate = [NSDate stringFromDate:ws.checkoutDate withFormat:@"yyyy-MM-dd"];
            model.isOverStay = @1;
            model.flag = @1;
            model.rentType = [NSNumber numberWithInteger:ws.rentType+1];
            if(ws.activityCouponFlag)
            {
                if(ws.activityCouponFlag.integerValue==1)//选择活动
                {
                    model.activityId = ws.selectActivity.activityId;
                }
                else if(ws.activityCouponFlag.integerValue==2)//优惠券
                {
                    model.cardCode = ws.selectCoupon.code;
                }
            }
            
            
            CalculatePriceRequest *request= [[CalculatePriceRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CalculatePriceRespModel *respModel = [request responseModel];
                
                ws.flag = respModel.data.flag;
                
                if(ws.rentType==1)//长租
                {
                    ws.deposit = respModel.data.bargainMoney;//押金
                }
                
                ws.totalMoney = respModel.data.price;
                
                if(ws.selectCoupon==nil && ws.selectActivity==nil)//如果没有选择活动和优惠券，前端置discount为0
                {
                    ws.discountMoneyNoXdollar = @0;
                }
                else
                {
                    ws.discountMoneyNoXdollar = respModel.data.discount;
                }
                
                ws.xdollar = respModel.data.xdollar;
                
                NSInteger actualPrice = ws.totalMoney.integerValue-ws.discountMoneyNoXdollar.integerValue;
                if(ws.xdollar.integerValue>actualPrice)
                {
                    ws.xdollarEnable = [NSNumber numberWithInteger:actualPrice];
                }
                else
                {
                    ws.xdollarEnable = ws.xdollar;
                }
                
                
                if(ws.xdollarFlag.boolValue)
                {
                    ws.discountMoney = [NSNumber numberWithInteger:ws.discountMoneyNoXdollar.integerValue+ws.xdollarEnable.integerValue];
                }
                else
                {
                    ws.discountMoney = ws.discountMoneyNoXdollar;
                }
                
                
                
                
                //第一次默认选中活动
                if(ws.activityCouponFlag==nil)
                {
                    ws.activityCouponFlag = @1;//默认选择活动
                    ws.selectCoupon = nil;
                    
                    for (NSInteger i=0;i<respModel.data.contents.count;i++)
                    {
                        if(respModel.data.contents[i].isDefault.boolValue)
                        {
                            ws.selectActivity = respModel.data.contents[i];
                            break;
                        }
                    }
                    
                    ws.activityData = respModel.data.contents;//第一次才存活动列表
                }
                
                if(respModel.data.couponCard)
                {
                    ws.couponData = @[respModel.data.couponCard.normals, respModel.data.couponCard.disableds];
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
    
    
    //生成订单
    _commendCreateOrder = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            

            
            CreateOrderRequestModel *model = [[CreateOrderRequestModel alloc] init];
            model.roomId = ws.roomId;
            model.price = ws.actualMoney;
            model.beginDate = [NSDate stringFromDate:ws.checkinDate withFormat:@"yyyy-MM-dd"];
            model.endDate = [NSDate stringFromDate:ws.checkoutDate withFormat:@"yyyy-MM-dd"];
            model.discount = ws.discountMoneyNoXdollar;
            model.rentType = [NSNumber numberWithInteger:ws.rentType+1];
            if(ws.selectActivity.activityId)
            {
                model.activityId = ws.selectActivity.activityId;
            }
            else
            {
                model.activityId = @-1;
            }
            model.cardCode = ws.selectCoupon.code;
            if(ws.xdollarFlag.boolValue)
            {
                model.xdollar = ws.xdollarEnable;
            }
            
            if(ws.rentType==0)
            {
                model.bargainMoney = @0;
            }
            else
            {
                model.bargainMoney = ws.deposit;
            }
            
            //口令
            if(ws.isWord)
            {
                if(![StringCheckUtil validateWord:ws.word])
                {
                    [subscriber sendNext:@"请正确填写口令"];
                    [subscriber sendCompleted];
                    
                    return nil;
                }
                else
                {
                    model.command = ws.word;
                    
                    if(ws.name.length)
                    {
                        model.commandName = ws.name;
                    }
                    
                    if(ws.phone.length)
                    {
                        if(![StringCheckUtil validatePhone:ws.phone])
                        {
                            [subscriber sendNext:@"请正确填写手机号码"];
                            [subscriber sendCompleted];
                            
                            return nil;
                        }
                        else
                        {
                            model.commandPhone = ws.phone;
                        }
                    }
                }
            }
            
            [LoadingView show];
            CreateOrderRequest *request = [[CreateOrderRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CreateOrderRespModel *respModel = [request responseModel];
                
                ws.orderNo = respModel.data.orderNo;
                ws.checkinId = respModel.data.checkinId;
                
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
    
    
    //生成续住单
    _commendCreateOverstayOrder = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            CreateOverstayOrderRequestModel *model = [[CreateOverstayOrderRequestModel alloc] init];
            model.checkinId = ws.checkinId;
            model.price = ws.actualMoney;
            model.endDate = [NSDate stringFromDate:ws.checkoutDate withFormat:@"yyyy-MM-dd"];
            model.discount = ws.discountMoneyNoXdollar;
            if(ws.selectActivity.activityId)
            {
                model.activityId = ws.selectActivity.activityId;
            }
            else
            {
                model.activityId = @-1;
            }
            model.cardCode = ws.selectCoupon.code;
            if(ws.xdollarFlag.boolValue)
            {
                model.xdollar = ws.xdollarEnable;
            }
            
            CreateOverstayOrderRequest *request = [[CreateOverstayOrderRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CreateOverstayOrderRespModel *respModel = [request responseModel];
                ws.orderNo = respModel.data;
                
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
    
    
    
    
    
    //微信支付
    _commendWechatPay = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            //获取微信支付参数
            [LoadingView show];
            WechatPayParamRequestModel *model = [[WechatPayParamRequestModel alloc] init];
            model.body = [NSString stringWithFormat:@"xbed-预订%@房间", ws.title];
            model.orderNo = ws.orderNo;
            model.checkinId = ws.checkinId;
            model.price = ws.actualMoney;
            
            WechatPayParamRequest *request = [[WechatPayParamRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                [LoadingView close];
                WechatPayParamRespModel *respModel = [request responseModel];
                ws.wechatPayParam = respModel.data;
                
                //发起支付
                [[LeoPayManager getInstance] wechatPayWithAppId:ws.wechatPayParam.appid partnerId:ws.wechatPayParam.partnerid prepayId:ws.wechatPayParam.prepayid package:ws.wechatPayParam.packageName nonceStr:ws.wechatPayParam.noncestr timeStamp:ws.wechatPayParam.timestamp sign:ws.wechatPayParam.sign];
                
                [[LeoPayManager getInstance] addWechatPayRespBlock:^(NSInteger respCode, NSString *respMsg) {
                    
                    if (respCode==0)//支付成功
                    {
                        [subscriber sendNext:nil];
                        [subscriber sendCompleted];
                    }
                    else
                    {
                        [subscriber sendNext:respMsg];
                        [subscriber sendCompleted];
                    }
                    
                }];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                [LoadingView close];
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    _commendWechatPay.allowsConcurrentExecution = YES;//重要，可重复执行
    
    //银联支付
    _commendUnionPay = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIViewController *input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            //获取银联支付参数
            [LoadingView show];
            UnionPayParamRequestModel *model = [[UnionPayParamRequestModel alloc] init];
            model.orderNo = ws.orderNo;
            model.checkinId = ws.checkinId;
            model.price = ws.actualMoney;
            
            UnionPayParamRequest *request = [[UnionPayParamRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                [LoadingView close];
                UnionPayParamRespModel *respModel = [request responseModel];
                ws.unionPayParam = respModel.data.payTN;
                
                
                //发起支付
                [[LeoPayManager getInstance] unionPayWithSerialNo:ws.unionPayParam viewController:input];
                
                [[LeoPayManager getInstance] addUnionPayRespBlock:^(NSInteger respCode, NSString *respMsg) {
                    
                    if (respCode==0)//支付成功
                    {
                        [subscriber sendNext:nil];
                        [subscriber sendCompleted];
                    }
                    else
                    {
                        [subscriber sendNext:respMsg];
                        [subscriber sendCompleted];
                    }
                    
                }];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                [LoadingView close];
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    
    //Apple Pay
    _commendApplePay = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIViewController *input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            ApplePayParamRequestModel *model = [[ApplePayParamRequestModel alloc] init];
            model.orderNo = ws.orderNo;
            model.checkinId = ws.checkinId;
            model.price = ws.actualMoney;
            ApplePayParamRequest *request = [[ApplePayParamRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                //ApplePayParamRespModel *respModel = [request responseModel];
                
                //LeoApplePayManager *manager = [LeoApplePayManager getInstance];
                //[manager payWithTN:respModel.data.payTN viewController:input];
                
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
