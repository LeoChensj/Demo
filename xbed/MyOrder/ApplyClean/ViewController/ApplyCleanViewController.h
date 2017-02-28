//
//  ApplyCleanViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "ApplyCleanViewModel.h"
#import "CleanTimeSelectView.h"
#import "BlueButton.h"

@interface ApplyCleanViewController : XbedViewController

@property (nonatomic, strong, readonly)CleanTimeSelectView *timeSelectView;
@property (nonatomic, strong, readonly)BlueButton *btnApply;

@property (nonatomic, strong)ApplyCleanViewModel *viewModel;

@end
