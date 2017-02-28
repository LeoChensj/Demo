//
//  SearchViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/7/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "SearchViewModel.h"
#import "SearchHeadView.h"
#import "SearchLocateView.h"
#import "HotCityView.h"
#import "SearchRecordView.h"
#import "SearchAssociateView.h"

@interface SearchViewController : XbedViewController

@property (nonatomic, strong, readonly)SearchHeadView *searchHeadView;

@property (nonatomic, strong, readonly)UIView *vContent1;//联想页显示，隐藏次view即可
@property (nonatomic, strong, readonly)SearchLocateView *locateView;
@property (nonatomic, strong, readonly)HotCityView *hotCityView;
@property (nonatomic, strong, readonly)SearchRecordView *recordView;
@property (nonatomic, strong, readonly)SearchAssociateView *associateView;


@property (nonatomic, strong)SearchViewModel *viewModel;

@end
