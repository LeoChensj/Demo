//
//  AuthenticationViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/26.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "AuthenticationViewModel.h"
#import "AuthenticationFaceCardView.h"
#import "STAlertView.h"

@interface AuthenticationViewController : XbedViewController

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)AuthenticationFaceCardView *faceCardView;
@property (nonatomic, strong)STAlertView *alertView;

@property (nonatomic, strong)AuthenticationViewModel *viewModel;

@end
