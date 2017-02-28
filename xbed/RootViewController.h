//
//  RootViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeoAdPageView.h"
#import "CustomTabBarController.h"

@interface RootViewController : UINavigationController

@property (nonatomic, strong)LeoAdPageView *adPageView;
@property (nonatomic, strong)CustomTabBarController *tabBarController;


+ (RootViewController *)getInstance;

@end
