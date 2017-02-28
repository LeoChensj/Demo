//
//  HomeMainViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/7/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"
#import "BannerModel.h"
#import "AdvertModel.h"
#import "HomeMainRequest.h"

@interface HomeMainViewModel : XbedViewModel

@property (nonatomic, strong)NSArray <BannerModel *>*bannerData;
@property (nonatomic, strong)NSArray <AdvertModel *>*adData1;//广告位数据
@property (nonatomic, strong)NSArray <AdvertModel *>*adData2;
@property (nonatomic, strong)NSArray <HomeMainModel *>*cityData;

@property (nonatomic, strong, readonly)RACSignal *signalCityData;
@property (nonatomic, strong, readonly)RACCommand *commandGetData;

@end
