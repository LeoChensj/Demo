//
//  ScreenConditionViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "ScreenRoomViewModel.h"
#import "RoomPriceSelectView.h"
#import "RoomTypeSelectView.h"
#import "RoomBedSelectView.h"
#import "RoomCharacteristicSelectView.h"
#import "TouchView.h"

@interface ScreenConditionViewController : XbedViewController

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)RoomPriceSelectView *priceView;
@property (nonatomic, strong, readonly)RoomTypeSelectView *typeView;
@property (nonatomic, strong, readonly)RoomBedSelectView *bedView;
@property (nonatomic, strong, readonly)RoomCharacteristicSelectView *characteristicView;
@property (nonatomic, strong, readonly)TouchView *btnSure;

@property (nonatomic, strong)ScreenRoomViewModel *viewModel;

@end
