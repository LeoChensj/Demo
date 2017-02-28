//
//  CardVerificationViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "CardVerificationViewModel.h"
#import "TouchEventScrollView.h"
#import "CardVerificationRemindTempView.h"
#import "CardVerificationPhotoView.h"
#import "CardVerificationInputView.h"
#import "BlueEnableButton.h"
#import "AuthenticationRemindLabel.h"

@interface CardVerificationViewController : XbedViewController

@property (nonatomic, strong, readonly)TouchEventScrollView *scrollView;
@property (nonatomic, strong, readonly)CardVerificationRemindTempView *remindTempView;
@property (nonatomic, strong, readonly)CardVerificationPhotoView *photoView;
@property (nonatomic, strong, readonly)CardVerificationInputView *inputView;
@property (nonatomic, strong, readonly)BlueEnableButton *btnSave;
@property (nonatomic, strong, readonly)AuthenticationRemindLabel *remindView;

@property (nonatomic, strong)CardVerificationViewModel *viewModel;

@end
