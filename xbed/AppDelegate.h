//
//  AppDelegate.h
//  xbed
//
//  Created by Leo.Chen on 16/7/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegateViewModel.h"
#import "STAlertView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic)UIWindow *window;
@property (strong, nonatomic)STAlertView *alertView;
@property (strong, nonatomic)AppDelegateViewModel *viewModel;

@end

