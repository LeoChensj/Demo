//
//  OrderDetailViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "CheckinOrderInfoRespModel.h"
#import "CheckinCleanRespModel.h"
#import "LeoPayManager.h"
#import "NearbyRoomModel.h"

@interface OrderDetailViewModel : XbedViewModel

/*
订单状态：
0 	已取消
1 	待支付
2	已支付-未清洁
3	已支付-未到办理入住时间
4   已支付-可办理入住  
5	已支付-需身份验证-拨号
6	已支付-需身份验证-不拨号
7	办理入住成功
8	已退房-未评价
9	已退房-已评价
10	已退房-评价已过期
*/

@property (nonatomic, strong)NSNumber *checkinId;

@property (nonatomic, strong)CheckinOrderInfoDataModel *checkinOrderInfo;
@property (nonatomic, strong)NSNumber *actualPrice;//应付金额，自己计算
@property (nonatomic, strong)NSNumber *isMyselfCheckin;//是否本人入住

@property (nonatomic, strong)CheckinCleanDataModel *checkinCleanInfo;
@property (nonatomic, assign)BOOL cancleCheckinOrderFlag;
@property (nonatomic, assign)BOOL overstayFlag;//是否能续住

@property (nonatomic, strong)NSArray <NearbyRoomModel *>*nearbyRoomData;


@property (nonatomic, strong, readonly)RACCommand *commandGetOrderDetailData;
@property (nonatomic, strong, readonly)RACCommand *commandCancleCheckinOrder;
@property (nonatomic, strong, readonly)RACCommand *commandCheckin;
@property (nonatomic, strong, readonly)RACCommand *commandCheckout;
@property (nonatomic, strong, readonly)RACCommand *commandCheckinClean;//判断是否可申请清洁
@property (nonatomic, strong, readonly)RACCommand *commandCancleCleanAndCleanTime;
@property (nonatomic, strong, readonly)RACCommand *commandVerifyOverstay;//判断是否能续住
@property (nonatomic, strong, readonly)RACCommand *commendWechatPay;
@property (nonatomic, strong, readonly)RACCommand *commendUnionPay;
@property (nonatomic, strong, readonly)RACCommand *commendOpenDoor;

@end
