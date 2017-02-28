//
//  FeedbackViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  意见反馈

#import "XbedViewController.h"
#import "FeedbackViewModel.h"
#import "FeedbackInputView.h"
#import "BlueEnableButton.h"

@interface FeedbackViewController : XbedViewController

@property (nonatomic, strong, readonly)FeedbackInputView *inputView;
@property (nonatomic, strong, readonly)BlueEnableButton *btnSubmit;
@property (nonatomic, strong, readonly)UIButton *btnPhone;

@property (nonatomic, strong)FeedbackViewModel *viewModel;

@end
