//
//  HomePageSelectView.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageRentSelectView.h"
#import "HomePageCitySelectView.h"
#import "HomePageDateSelectView.h"
#import "HomePageSearchView.h"
#import "BlueEnableButton.h"
#import "SearchRespModel.h"

@interface HomePageSelectView : UIView

@property (nonatomic, strong, readonly)HomePageRentSelectView *rentSelectView;
@property (nonatomic, strong, readonly)HomePageCitySelectView *citySelectView;
@property (nonatomic, strong, readonly)HomePageDateSelectView *dateSelectView;
@property (nonatomic, strong, readonly)HomePageSearchView *searchView;
@property (nonatomic, strong, readonly)UILabel *lbLongRentRemind;
@property (nonatomic, strong, readonly)BlueEnableButton *btnCheck;

@property (nonatomic, assign)NSInteger rentType;//0：短租   1：长租

@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;
@property (nonatomic, strong)SearchModel *searchModel;


@end
