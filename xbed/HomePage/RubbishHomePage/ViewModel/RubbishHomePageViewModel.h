//
//  RubbishHomePageViewModel.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "BannerModel.h"
#import "AdvertModel.h"
#import "HomeMainRequest.h"
#import "SearchRespModel.h"

@interface RubbishHomePageViewModel : XbedViewModel

@property (nonatomic, strong)NSArray <BannerModel *>*bannerData;
@property (nonatomic, strong)NSArray <NSString *>*hotCities;
@property (nonatomic, strong)NSArray <NSString *>*longRentCities;
@property (nonatomic, strong)NSArray <AdvertModel *>*adData;

@property (nonatomic, assign)NSInteger rentType;//0：短租   1：长租
@property (nonatomic, strong)NSString *city;//选择的城市
@property (nonatomic, strong)NSString *city1;//短租
@property (nonatomic, strong)NSString *city2;//长租
@property (nonatomic, strong)NSDate *today;
@property (nonatomic, strong)NSDate *checkinDate;
@property (nonatomic, strong)NSDate *checkoutDate;
@property (nonatomic, strong)SearchModel *searchModel;
@property (nonatomic, strong)SearchModel *searchModel1;//短租
@property (nonatomic, strong)SearchModel *searchModel2;//长租


@property (nonatomic, strong, readonly)RACCommand *commandGetHomePageData;
@property (nonatomic, strong, readonly)RACCommand *commandGetHomePageDataFromLocal;

@end
