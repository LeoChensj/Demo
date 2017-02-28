//
//  XcleanViewController.h
//  xclean
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"

@interface XbedViewController : UIViewController 

@property (nonatomic, strong)HeadView *headView;
@property (nonatomic, strong)UIView *baseView;

- (void)setupPopGestureRecognizerEnable:(BOOL)enable;

- (void)config;
- (void)setupNavigationBar;
- (void)setupView;
- (void)bindViewModel;
- (void)handleEvent;

- (void)back;

@end
