//
//  MyXdollarViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "MyXdollarViewModel.h"
#import "MyXdollarBaseInfoView.h"
#import "MyXdollarRulesView.h"

@interface MyXdollarViewController : XbedViewController

@property (nonatomic, strong, readonly)MyXdollarBaseInfoView *baseInfoView;
@property (nonatomic, strong, readonly)MyXdollarRulesView *rulesView;
@property (nonatomic, strong, readonly)UIButton *btnDetail;

@property (nonatomic, strong)MyXdollarViewModel *viewModel;

@end
