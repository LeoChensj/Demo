//
//  OrderListRespModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRespModel.h"

@interface OrderListRoomInfoModel : XbedModel

@property (nonatomic, strong)NSString *custRoomAddr;
@property (nonatomic, strong)NSString *custRoomName;
@property (nonatomic, strong)NSString *custRoomNo;
@property (nonatomic, strong)NSString *picture;
@property (nonatomic, strong)NSNumber *roomFloor;

@end

@interface CheckinOrderListModel : XbedModel

@property (nonatomic, strong)NSNumber *checkinId;
@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;
@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSNumber *price;
@property (nonatomic, strong)NSNumber *roomDay;
@property (nonatomic, strong)NSString *command;
@property (nonatomic, strong)NSString *commandName;
@property (nonatomic, strong)NSString *commandPhone;
@property (nonatomic, strong)NSNumber *commandState;
@property (nonatomic, strong)OrderListRoomInfoModel *roomInfo;

@end

@interface OrderListContnetModel : XbedModel

@property (nonatomic, strong)NSArray <CheckinOrderListModel *>*checkinOrderList;
@property (nonatomic, strong)NSNumber *type;
@property (nonatomic, strong)NSNumber *state;//发票选择订单列表用

@end

@interface OrderListDataModel : XbedModel

@property (nonatomic, strong)NSArray <OrderListContnetModel *>*contents;
@property (nonatomic, strong)NSNumber *totalElements;
@property (nonatomic, strong)NSNumber *totalPages;

@end

@interface OrderListRespModel : XbedRespModel

@property (nonatomic, strong)OrderListDataModel *data;

@end
