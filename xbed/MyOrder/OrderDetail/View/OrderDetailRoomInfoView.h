//
//  OrderDetailRoomInfoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/30.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchView.h"
#import "CheckinOrderInfoRespModel.h"

@interface OrderDetailRoomInfoView : UIView
{
@private
    UIImageView *_imgvRoom;
    UILabel *_lbTitle;
    UILabel *_lbDesc;
    UILabel *_lbAddress;
    UILabel *_lbDate;
}

@property (nonatomic, strong, readonly)TouchView *btnRoomInfo;
@property (nonatomic, strong, readonly)TouchView *btnRoomAddress;
@property (nonatomic, assign, readonly)CGFloat myHeight;

@property (nonatomic, strong)NSNumber *orderType;
@property (nonatomic, strong)CheckinOrderRoomInfoModel *roomInfo;
@property (nonatomic, strong)CheckinOrderInfoModel *checkinInfo;


@end
