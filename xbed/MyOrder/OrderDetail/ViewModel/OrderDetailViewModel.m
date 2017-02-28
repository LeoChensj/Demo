//
//  OrderDetailViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailViewModel.h"
#import "CalendarHandle.h"
#import "CheckinOrderInfoRequest.h"
#import "CheckinRequest.h"
#import "CheckoutRequest.h"
#import "CheckinCleanRequest.h"
#import "CancleCheckinCleanRequest.h"
#import "CleanTimeRequest.h"
#import "CancleCheckinRequest.h"
#import "VerifyOverstayRequest.h"
#import "WechatPayParamRequest.h"
#import "UnionPayParamRequest.h"
#import "OpenDoorRequest.h"

@implementation OrderDetailViewModel

- (void)setupSignal
{
    WS(ws);
    [RACObserve(self, checkinOrderInfo) subscribeNext:^(CheckinOrderInfoDataModel *x) {
        
        if(x)
        {
            if(x.payInfo)
            {
                if(x.rentType.integerValue==1)//短租
                {
                    ws.actualPrice = [NSNumber numberWithInteger:(x.payInfo.price.integerValue-x.payInfo.discount.integerValue)];
                }
                else//长租
                {
                    ws.actualPrice = [NSNumber numberWithInteger:(x.payInfo.bargainMoney.integerValue+x.payInfo.price.integerValue-x.payInfo.discount.integerValue)];
                }
            }
            
            /*
            if(x.evaluated.nearRoomList.count)
            {
                NSMutableArray <NearbyRoomModel *>*nearbyRooms = [NSMutableArray array];
                for (NSInteger i=0;i<x.evaluated.nearRoomList.count;i++)
                {
                    NearbyRoomModel *nearModel = [[NearbyRoomModel alloc] init];
                    nearModel.roomId = x.evaluated.nearRoomList[i].roomId;
                    nearModel.image = x.evaluated.nearRoomList[i].coverPic;
                    nearModel.title = x.evaluated.nearRoomList[i].custRoomName;
                    nearModel.roomType = x.evaluated.nearRoomList[i].houseType;
                    nearModel.person = x.evaluated.nearRoomList[i].liveCount;
                    if(x.evaluated.nearRoomList[i].roomGrade && x.evaluated.nearRoomList[i].cleanGrade)
                    {
                        nearModel.score = [NSNumber numberWithFloat:(x.evaluated.nearRoomList[i].roomGrade.floatValue+x.evaluated.nearRoomList[i].cleanGrade.floatValue)*0.5];
                    }
                    nearModel.distance = x.evaluated.nearRoomList[i].distance;
                    nearModel.price = x.evaluated.nearRoomList[i].price;
                    
                    [nearbyRooms addObject:nearModel];
                }
                
                ws.nearbyRoomData = nearbyRooms;
            }
            
            
            if(x.overdue.nearRoomList.count)
            {
                NSMutableArray <NearbyRoomModel *>*nearbyRooms = [NSMutableArray array];
                for (NSInteger i=0;i<x.overdue.nearRoomList.count;i++)
                {
                    NearbyRoomModel *nearModel = [[NearbyRoomModel alloc] init];
                    nearModel.roomId = x.overdue.nearRoomList[i].roomId;
                    nearModel.image = x.overdue.nearRoomList[i].coverPic;
                    nearModel.title = x.overdue.nearRoomList[i].custRoomName;
                    nearModel.roomType = x.overdue.nearRoomList[i].houseType;
                    nearModel.person = x.overdue.nearRoomList[i].liveCount;
                    if(x.overdue.nearRoomList[i].roomGrade && x.overdue.nearRoomList[i].cleanGrade)
                    {
                        nearModel.score = [NSNumber numberWithFloat:(x.overdue.nearRoomList[i].roomGrade.floatValue+x.overdue.nearRoomList[i].cleanGrade.floatValue)*0.5];
                    }
                    nearModel.distance = x.overdue.nearRoomList[i].distance;
                    nearModel.price = x.overdue.nearRoomList[i].price;
                    
                    [nearbyRooms addObject:nearModel];
                }
                
                ws.nearbyRoomData = nearbyRooms;
            }
            */
        }
        
    }];
    
    
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetOrderDetailData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            CheckinOrderInfoRequestModel *model = [[CheckinOrderInfoRequestModel alloc] init];
            model.checkinId = ws.checkinId;
            
            CheckinOrderInfoRequest *request = [[CheckinOrderInfoRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CheckinOrderInfoRespModel *respModel = [request responseModel];
                
                ws.checkinOrderInfo = respModel.data;
                
                
                
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
    
    
    _commandCancleCheckinOrder = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            CancleCheckinRequestModel *model = [[CancleCheckinRequestModel alloc] init];
            model.checkinId = ws.checkinOrderInfo.checkinOrderInfo.checkinId;
            model.orderNo = ws.checkinOrderInfo.checkinOrderInfo.orderNo;
            
            CancleCheckinRequest *request = [[CancleCheckinRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CancleCheckinRespModel *respModel = [request responseModel];
                
                if(respModel.data && respModel.data.type && respModel.data.type.integerValue==1)
                {
                    ws.cancleCheckinOrderFlag = YES;
                }
                else//取消入住单成功
                {
                    CheckinOrderInfoDataModel *checkinOrderInfo = ws.checkinOrderInfo;
                    checkinOrderInfo.type = @0;
                    ws.checkinOrderInfo = checkinOrderInfo;
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
    
    
    
    _commandCheckin = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            CheckinRequestModel *model = [[CheckinRequestModel alloc] init];
            model.checkinId = ws.checkinOrderInfo.checkinOrderInfo.checkinId;
            
            CheckinRequest *request = [[CheckinRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CheckinRespModel *respModel = [request responseModel];
                
                
                CheckinOrderInfoDataModel *checkinOrderInfo = ws.checkinOrderInfo;
                
                if(respModel.data.openPwd.length)
                {
                    checkinOrderInfo.checkinOrderInfo.openPwd = respModel.data.openPwd;
                }
                
                if(respModel.data.verify.boolValue)
                {
                    checkinOrderInfo.type = @5;
                }
                else
                {
                    checkinOrderInfo.type = @7;
                }
                
                ws.checkinOrderInfo = checkinOrderInfo;
                
                
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
    
    
    
    
    _commandCheckout = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            CheckoutRequestModel *model = [[CheckoutRequestModel alloc] init];
            model.checkinId = ws.checkinOrderInfo.checkinOrderInfo.checkinId;
            model.roomId = ws.checkinOrderInfo.checkinOrderInfo.roomId;
            
            CheckoutRequest *request = [[CheckoutRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CheckinOrderInfoDataModel *checkinOrderInfo = ws.checkinOrderInfo;
                ws.checkinOrderInfo.type = @8;
                
                ws.checkinOrderInfo = checkinOrderInfo;
                
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
    
    
    
    _commandCheckinClean = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            CheckinCleanRequestModel *model = [[CheckinCleanRequestModel alloc] init];
            model.orderNo = ws.checkinOrderInfo.checkinOrderInfo.orderNo;
            model.checkinId = ws.checkinOrderInfo.checkinOrderInfo.checkinId;
            
            CheckinCleanRequest *request = [[CheckinCleanRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CheckinCleanRespModel *respModel = [request responseModel];
                ws.checkinCleanInfo = respModel.data;
                
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
    
    
    _commandCancleCleanAndCleanTime = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            CancleCheckinCleanRequestModel *model1 = [[CancleCheckinCleanRequestModel alloc] init];
            model1.orderNo = ws.checkinOrderInfo.checkinOrderInfo.orderNo;
            model1.checkinId = ws.checkinOrderInfo.checkinOrderInfo.checkinId;
            
            CancleCheckinCleanRequest *request1 = [[CancleCheckinCleanRequest alloc] initWithRequestModel:model1];
            [request1 startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CleanTimeRequestModel *model2 = [[CleanTimeRequestModel alloc] init];
                model2.checkinId = ws.checkinOrderInfo.checkinOrderInfo.checkinId;
                
                CleanTimeRequest *request2 = [[CleanTimeRequest alloc] initWithRequestModel:model2];
                [request2 startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request2) {
                    
                    CleanTimeRespModel *respModel2 = (CleanTimeRespModel *)[request2 respModel];
                    
                    ws.checkinCleanInfo.cleanTime = respModel2.data;
                    
                    
                    [LoadingView close];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                    
                } failure:^(__kindof LeoBaseRequest *request) {
                    
                    [LoadingView close];
                    [subscriber sendNext:[request getErrorMsg]];
                    [subscriber sendCompleted];
                    
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
    
    
    
    
    _commandVerifyOverstay = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            VerifyOverstayRequestModel *model = [[VerifyOverstayRequestModel alloc] init];
            model.checkinId = ws.checkinOrderInfo.checkinOrderInfo.checkinId;
            
            VerifyOverstayRequest *request = [[VerifyOverstayRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                VerifyOverstayRespModel *respModel = [request responseModel];
                ws.overstayFlag = respModel.data.integerValue;
                
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
            model.body = [NSString stringWithFormat:@"xbed-预订%@房间", ws.checkinOrderInfo.roomInfo.custRoomName];
            model.orderNo = ws.checkinOrderInfo.checkinOrderInfo.orderNo;
            model.checkinId = ws.checkinOrderInfo.checkinOrderInfo.checkinId;
            if(ws.checkinOrderInfo.payInfo.changeRoom.boolValue)
            {
                model.price = ws.checkinOrderInfo.payInfo.waitPay;
            }
            else
            {
                model.price = ws.actualPrice;
            }
            
            
            WechatPayParamRequest *request = [[WechatPayParamRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                [LoadingView close];
                WechatPayParamRespModel *respModel = [request responseModel];
                
                //发起支付
                [[LeoPayManager getInstance] wechatPayWithAppId:respModel.data.appid partnerId:respModel.data.partnerid prepayId:respModel.data.prepayid package:respModel.data.packageName nonceStr:respModel.data.noncestr timeStamp:respModel.data.timestamp sign:respModel.data.sign];
                
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
            model.orderNo = ws.checkinOrderInfo.checkinOrderInfo.orderNo;
            model.checkinId = ws.checkinOrderInfo.checkinOrderInfo.checkinId;
            if(ws.checkinOrderInfo.payInfo.changeRoom.boolValue)
            {
                model.price = ws.checkinOrderInfo.payInfo.waitPay;
            }
            else
            {
                model.price = ws.actualPrice;
            }
            
            UnionPayParamRequest *request = [[UnionPayParamRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                [LoadingView close];
                UnionPayParamRespModel *respModel = [request responseModel];
                
                //发起支付
                [[LeoPayManager getInstance] unionPayWithSerialNo:respModel.data.payTN viewController:input];
                
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
    
    
    
    _commendOpenDoor = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *idCard = [DBManager getInstance].loginModel.idNo;
            
            [LoadingView show];
            NetworkOpenDoorRequestModel *model = [[NetworkOpenDoorRequestModel alloc] init];
            model.idCard = [idCard substringWithRange:NSMakeRange(idCard.length-6, 6)];
            model.roomId = ws.checkinOrderInfo.checkinOrderInfo.roomId;
            
            OpenDoorRequest *request = [[OpenDoorRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
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





//附近房源
- (NSArray<NearbyRoomModel *> *)nearbyRoomData
{
    if(_nearbyRoomData==nil)
    {
        if(self.checkinOrderInfo.evaluated.nearRoomList.count)
        {
            NSMutableArray <NearbyRoomModel *>*nearbyRooms = [NSMutableArray array];
            for (NSInteger i=0;i<self.checkinOrderInfo.evaluated.nearRoomList.count;i++)
            {
                NearbyRoomModel *nearModel = [[NearbyRoomModel alloc] init];
                nearModel.roomId = self.checkinOrderInfo.evaluated.nearRoomList[i].roomId;
                nearModel.image = self.checkinOrderInfo.evaluated.nearRoomList[i].coverPic;
                nearModel.title = self.checkinOrderInfo.evaluated.nearRoomList[i].custRoomName;
                nearModel.roomType = self.checkinOrderInfo.evaluated.nearRoomList[i].houseType;
                nearModel.person = self.checkinOrderInfo.evaluated.nearRoomList[i].liveCount;
                if(self.checkinOrderInfo.evaluated.nearRoomList[i].roomGrade && self.checkinOrderInfo.evaluated.nearRoomList[i].cleanGrade)
                {
                    nearModel.score = [NSNumber numberWithFloat:(self.checkinOrderInfo.evaluated.nearRoomList[i].roomGrade.floatValue+self.checkinOrderInfo.evaluated.nearRoomList[i].cleanGrade.floatValue)*0.5];
                }
                nearModel.distance = self.checkinOrderInfo.evaluated.nearRoomList[i].distance;
                nearModel.price = self.checkinOrderInfo.evaluated.nearRoomList[i].price;
                
                [nearbyRooms addObject:nearModel];
            }
            
            _nearbyRoomData = nearbyRooms;
        }
        
        if(self.checkinOrderInfo.overdue.nearRoomList.count)
        {
            NSMutableArray <NearbyRoomModel *>*nearbyRooms = [NSMutableArray array];
            for (NSInteger i=0;i<self.checkinOrderInfo.overdue.nearRoomList.count;i++)
            {
                NearbyRoomModel *nearModel = [[NearbyRoomModel alloc] init];
                nearModel.roomId = self.checkinOrderInfo.overdue.nearRoomList[i].roomId;
                nearModel.image = self.checkinOrderInfo.overdue.nearRoomList[i].coverPic;
                nearModel.title = self.checkinOrderInfo.overdue.nearRoomList[i].custRoomName;
                nearModel.roomType = self.checkinOrderInfo.overdue.nearRoomList[i].houseType;
                nearModel.person = self.checkinOrderInfo.overdue.nearRoomList[i].liveCount;
                if(self.checkinOrderInfo.overdue.nearRoomList[i].roomGrade && self.checkinOrderInfo.overdue.nearRoomList[i].cleanGrade)
                {
                    nearModel.score = [NSNumber numberWithFloat:(self.checkinOrderInfo.overdue.nearRoomList[i].roomGrade.floatValue+self.checkinOrderInfo.overdue.nearRoomList[i].cleanGrade.floatValue)*0.5];
                }
                nearModel.distance = self.checkinOrderInfo.overdue.nearRoomList[i].distance;
                nearModel.price = self.checkinOrderInfo.overdue.nearRoomList[i].price;
                
                [nearbyRooms addObject:nearModel];
            }
            
            _nearbyRoomData = nearbyRooms;
        }
    }
    
    return _nearbyRoomData;
}

@end
