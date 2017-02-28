//
//  OrderDetailViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "OrderDetailViewModel.h"
#import "OrderDetailScrollView.h"
#import "OrderDetailOrderNoView.h"
#import "OrderDetailOrderStateView.h"
#import "OrderDetailRoomInfoView.h"
#import "OrderDetailOpenDoorPwdView.h"
#import "OrderDetailBelowLineVerifyView.h"
#import "OrderDetailCheckinPersonView.h"
#import "OrderDetailPriceView.h"
#import "OrderDetailRemindView.h"
#import "OrderDetailRoomServiceView.h"

#import "RoomEvaluateStarView.h"
#import "RoomEvaluateContentView.h"
#import "RoomEvaluatePhotoView.h"
#import "RoomDetailNearbyRoomView.h"
#import "EvaluateOverdueStarView.h"

#import "BlueButton.h"

@interface OrderDetailViewController : XbedViewController

@property (nonatomic, strong)OrderDetailScrollView *scrollView;

@property (nonatomic, strong)OrderDetailOrderNoView *orderNoView;
@property (nonatomic, strong)OrderDetailOrderStateView *orderStateView;
@property (nonatomic, strong)OrderDetailRoomInfoView *roomInfoView;
@property (nonatomic, strong)OrderDetailOpenDoorPwdView *openDoorPwdView;
@property (nonatomic, strong)OrderDetailBelowLineVerifyView *belowLineVerifyView;
@property (nonatomic, strong)OrderDetailCheckinPersonView *checkinPersonView;
@property (nonatomic, strong)OrderDetailPriceView *priceView;
@property (nonatomic, strong)OrderDetailRemindView *remindView;
@property (nonatomic, strong)OrderDetailRoomServiceView *roomServiceView;

@property (nonatomic, strong)RoomEvaluateStarView *roomStarView;
@property (nonatomic, strong)RoomEvaluateStarView *cleanStarView;
@property (nonatomic, strong)RoomEvaluateContentView *evaluateContentView;
@property (nonatomic, strong)RoomEvaluatePhotoView *evaluatedPhotoView;
@property (nonatomic, strong)RoomDetailNearbyRoomView *nearbyRoomView;
@property (nonatomic, strong)EvaluateOverdueStarView *evaluateOverdueStarView;


@property (nonatomic, strong)BlueButton *btnHandle;
@property (nonatomic, strong)STAlertView *alertView;


@property (nonatomic, strong)OrderDetailViewModel *viewModel;

@end
