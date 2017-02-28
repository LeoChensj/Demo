//
//  OrderDetailCheckinPersonView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  选择入住人

#import <UIKit/UIKit.h>
#import "TouchView.h"
#import "CheckinOrderInfoRespModel.h"
#import "CheckinPersonListView.h"

@interface OrderDetailCheckinPersonView : UIView

@property (nonatomic, strong, readonly)CheckinPersonListView *checkinPersonListView;
@property (nonatomic, strong, readonly)UISwitch *swtMyself;
@property (nonatomic, strong, readonly)TouchView *btnAddCheckinPerson;
@property (nonatomic, assign)CGFloat myHeight;

@property (nonatomic, strong)NSNumber *isMyself;
@property (nonatomic, strong)NSNumber *checkinerType;
@property (nonatomic, strong)NSMutableArray <CheckinOrderCheckinerModel *>*sharers;

@end
