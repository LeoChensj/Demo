//
//  RoomEvaluateViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/10/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "CleanEvaluateViewModel.h"
#import "TouchEventScrollView.h"
#import "CleanEvaluateBaseInfoView.h"
#import "CleanEvaluateStarView.h"
#import "EvaluateInputView.h"
#import "EvaluatePhotoView.h"

@interface CleanEvaluateViewController : XbedViewController

@property (nonatomic, strong)CleanEvaluateViewModel *viewModel;

@property (nonatomic, strong, readonly)TouchEventScrollView *scrollView;
@property (nonatomic, strong, readonly)CleanEvaluateBaseInfoView *baseInfoView;
@property (nonatomic, strong, readonly)CleanEvaluateStarView *starView;
@property (nonatomic, strong, readonly)EvaluateInputView *inputView;
@property (nonatomic, strong, readonly)EvaluatePhotoView *evaluatePhotoView;

@end
