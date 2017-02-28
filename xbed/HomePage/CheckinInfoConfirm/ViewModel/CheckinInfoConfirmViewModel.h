//
//  CheckinInfoConfirmViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "RoomStatusRespModel.h"
#import "CalculatePriceRespModel.h"
#import "WechatPayParamRespModel.h"
#import "LeoPayManager.h"
#import "ApplePayParamRespModel.h"

@interface CheckinInfoConfirmViewModel : XbedViewModel

@property (nonatomic, assign)NSInteger rentType;//0:短租  1:长租
@property (nonatomic, assign)NSInteger type;//0:普通信息确认   1:续住信息确认
@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSString *roomImage;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *roomType;
@property (nonatomic, strong)NSNumber *person;


//日历数据
@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSArray <RoomDetailRoomStatusModel *>*roomStatus;

@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;

@property (nonatomic, strong)NSArray <NSArray <CouponCardModel *>*>*couponData;
@property (nonatomic, strong)NSArray <ActivityContentsModel *>*activityData;

@property (nonatomic, strong)NSNumber *activityCouponFlag;//1表示选择活动，2表示选择优惠券
@property (nonatomic, strong)ActivityContentsModel *selectActivity;//选择的活动
@property (nonatomic, strong)CouponCardModel *selectCoupon;//选择的优惠券

@property (nonatomic, assign)BOOL isWord;//是否生成口令
@property (nonatomic, strong)NSString *word;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *phone;

@property (nonatomic, strong)NSNumber *xdollar;//总的
@property (nonatomic, strong)NSNumber *xdollarEnable;//可用的
@property (nonatomic, strong)NSNumber *xdollarFlag;//是否使用xdollar

@property (nonatomic, strong)NSNumber *deposit;//押金
@property (nonatomic, strong)NSNumber *totalMoney;
@property (nonatomic, strong)NSNumber *discountMoney;//实际优惠，包括Xdollar
@property (nonatomic, strong)NSNumber *discountMoneyNoXdollar;//接口算出来的优惠，没有Xdollar
@property (nonatomic, strong)NSNumber *actualMoney;

@property (nonatomic, strong)NSNumber *flag;//是否0-6点预订

@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSNumber *checkinId;

@property (nonatomic, strong)ApplePayParamDataModel *applePayParam;
@property (nonatomic, strong)WechatPayParamDataModel *wechatPayParam;
@property (nonatomic, strong)NSString *unionPayParam;






@property (nonatomic, strong, readonly)RACSignal *signalDate;
@property (nonatomic, strong, readonly)RACSignal *signalActivityCoupon;//选择优惠券或活动
@property (nonatomic, strong, readonly)RACSignal *signalEnablePay;
@property (nonatomic, strong, readonly)RACCommand *commendGetCalendarData;
@property (nonatomic, strong, readonly)RACCommand *commendGetOrderData;
@property (nonatomic, strong, readonly)RACCommand *commendCreateOrder;
@property (nonatomic, strong, readonly)RACCommand *commendCreateOverstayOrder;//生成续住单
@property (nonatomic, strong, readonly)RACCommand *commendApplePay;
@property (nonatomic, strong, readonly)RACCommand *commendWechatPay;
@property (nonatomic, strong, readonly)RACCommand *commendAliPay;
@property (nonatomic, strong, readonly)RACCommand *commendUnionPay;

@end
