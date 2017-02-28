//
//  RoomEvaluateViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  房间评价

#import "XbedViewController.h"
#import "TouchEventScrollView.h"
#import "RoomEvaluateViewModel.h"
#import "RoomEvaluateBaseInfoView.h"
#import "RoomEvaluateStarView.h"
#import "CleanEvaluateStarView.h"
#import "EvaluateInputView.h"
#import "EvaluatePhotoView.h"
#import "RoomEvaluateContentView.h"
#import "RoomEvaluatePhotoView.h"
#import "RoomDetailNearbyRoomView.h"
#import "EvaluateOverdueStarView.h"
#import "BlueButton.h"

@interface RoomEvaluateViewController : XbedViewController

@property (nonatomic, strong, readonly)TouchEventScrollView *scrollView;
@property (nonatomic, strong, readonly)RoomEvaluateBaseInfoView *baseInfoView;
@property (nonatomic, strong)RoomEvaluateStarView *roomStarView;
@property (nonatomic, strong)RoomEvaluateStarView *cleanStarView;
@property (nonatomic, strong)EvaluateInputView *evaluateInputView;
@property (nonatomic, strong)EvaluatePhotoView *evaluatePhotoSelectView;
@property (nonatomic, strong)RoomEvaluateContentView *evaluateContentView;
@property (nonatomic, strong)RoomEvaluatePhotoView *evaluatedPhotoView;
@property (nonatomic, strong)RoomDetailNearbyRoomView *nearbyRoomView;
@property (nonatomic, strong)EvaluateOverdueStarView *evaluateOverdueStarView;

@property (nonatomic, strong)BlueButton *btnBook;

@property (nonatomic, strong)STAlertView *alertView;


@property (nonatomic, strong)RoomEvaluateViewModel *viewModel;

@end
