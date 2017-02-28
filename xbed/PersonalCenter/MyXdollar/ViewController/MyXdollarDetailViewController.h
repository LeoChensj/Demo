//
//  MyXdollarDetailViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "MyXdollarDetailViewModel.h"
#import "XdollarDetailListView.h"

@interface MyXdollarDetailViewController : XbedViewController

@property (nonatomic, strong, readonly)XdollarDetailListView *xdollarDetailListView;

@property (nonatomic, strong)MyXdollarDetailViewModel *viewModel;

@end
