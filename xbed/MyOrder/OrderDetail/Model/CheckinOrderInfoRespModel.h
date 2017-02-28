//
//  CheckinOrderInfoRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"
#import "GetRoomEvaluateRespModel.h"

@interface CheckinOrderRoomInfoModel : XbedModel

@property (nonatomic, strong)NSString *custRoomAddr;
@property (nonatomic, strong)NSString *custRoomName;
@property (nonatomic, strong)NSString *custRoomNo;
@property (nonatomic, strong)NSString *houseType;
@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSNumber *liveCount;
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSString *picture;
@property (nonatomic, strong)NSArray <NSString *>*remind;
@property (nonatomic, strong)NSNumber *roomFloor;
@property (nonatomic, strong)NSArray <NSString *>*naviPic;
@property (nonatomic, strong)NSArray <NSString *>*traffic;
@property (nonatomic, strong)NSNumber *flag;

@end

@interface CheckinOrderPayInfoPriceListModel : XbedModel

@property (nonatomic, strong)NSDate *curDate;
@property (nonatomic, strong)NSNumber *price;

@end

@interface CheckinOrderPayInfoModel : XbedModel

@property (nonatomic, strong)NSNumber *changeRoom;
@property (nonatomic, strong)NSNumber *bargainMoney;
@property (nonatomic, strong)NSNumber *canPay;
@property (nonatomic, strong)NSNumber *discount;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSNumber *userPay;
@property (nonatomic, strong)NSNumber *waitPay;
@property (nonatomic, strong)NSArray <CheckinOrderPayInfoPriceListModel *>*curPriceList;

@end

@interface CheckinOrderCheckinerModel : XbedModel

@property (nonatomic, strong)NSNumber *id;
@property (nonatomic, strong)NSString *idNo;
@property (nonatomic, strong)NSNumber *infoId;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *phone;

@end

@interface CheckinOrderInfoModel : XbedModel

@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSDate *checkoutDate;
@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSNumber *roomDay;
@property (nonatomic, strong)NSNumber *roomId;
@property (nonatomic, strong)NSString *openPwd;

@end

@interface CheckinOrderInfoDataModel : XbedModel

@property (nonatomic, strong)CheckinOrderInfoModel *checkinOrderInfo;
@property (nonatomic, strong)NSMutableArray <CheckinOrderCheckinerModel *>*checkinerList;
@property (nonatomic, strong)NSNumber *checkinerType;
@property (nonatomic, strong)NSString *contactPhone;
@property (nonatomic, strong)CheckinOrderPayInfoModel *payInfo;
@property (nonatomic, strong)CheckinOrderRoomInfoModel *roomInfo;
@property (nonatomic, strong)NSString *shareUrl;
@property (nonatomic, strong)NSNumber *type;
@property (nonatomic, strong)NSNumber *rentType;
@property (nonatomic, strong)NSNumber *source;

@property (nonatomic, strong)GetRoomEvaluateWaitEvaluateModel *waitEvaluate;
@property (nonatomic, strong)GetRoomEvaluateEvaluatedModel *evaluated;
@property (nonatomic, strong)GetRoomEvaluateOverdueModel *overdue;

@end

@interface CheckinOrderInfoRespModel : XbedRespModel

@property (nonatomic, strong)CheckinOrderInfoDataModel *data;

@end
