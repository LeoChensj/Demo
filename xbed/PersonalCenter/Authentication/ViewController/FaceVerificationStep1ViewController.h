//
//  FaceVerificationStep1ViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "FaceVerificationViewModel.h"
#import "FaceVerificationInputView.h"
#import "BlueEnableButton.h"
#import "AuthenticationRemindLabel.h"

@interface FaceVerificationStep1ViewController : XbedViewController

@property (nonatomic, strong, readonly)FaceVerificationInputView *inputView;
@property (nonatomic, strong, readonly)BlueEnableButton *btnNext;
@property (nonatomic, strong, readonly)AuthenticationRemindLabel *remindView;
@property (nonatomic, strong)STAlertView *alertView;

@property (nonatomic, strong)FaceVerificationViewModel *viewModel;

@end
