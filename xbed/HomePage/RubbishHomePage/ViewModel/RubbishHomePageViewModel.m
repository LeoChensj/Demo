//
//  RubbishHomePageViewModel.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RubbishHomePageViewModel.h"

@implementation RubbishHomePageViewModel

- (void)initProperty
{
    self.city = @"广州市";
    self.city1 = @"广州市";
    self.city2 = @"广州市";
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetHomePageData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            HomeMainRequestModel *model = [[HomeMainRequestModel alloc] init];
            HomeMainRequest *request = [[HomeMainRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                HomeMainRespModel *respModel = [request responseModel];
                
                //数据持久化
                [DBManager getInstance].homePageData = respModel.data;
                
                
                
                NSMutableArray <BannerModel *>*bannerData = [NSMutableArray array];
                for(NSInteger i=0;i<respModel.data.advert1Array.count;i++)
                {
                    BannerModel *model = [[BannerModel alloc] init];
                    model.imageUrl = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", respModel.data.advert1Array[i].picPath, (NSInteger)(MAIN_SCREEN_WIDTH*2)];
                    model.url = respModel.data.advert1Array[i].url;
                    
                    [bannerData addObject:model];
                }
                ws.bannerData = bannerData;
                
                
                NSMutableArray <AdvertModel *>*adData2 = [NSMutableArray array];
                for(NSInteger i=0;i<respModel.data.advert3Array.count;i++)
                {
                    AdvertModel *model = [[AdvertModel alloc] init];
                    model.title = respModel.data.advert3Array[i].name;
                    model.desc = respModel.data.advert3Array[i].remark;
                    model.imageUrl = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", respModel.data.advert3Array[i].picPath, (NSInteger)(MAIN_SCREEN_WIDTH-30)];
                    model.url = respModel.data.advert3Array[i].url;
                    
                    [adData2 addObject:model];
                }
                ws.adData = adData2;
                
                ws.hotCities = respModel.data.cities;
                ws.longRentCities = respModel.data.longRentCities;
                ws.today = respModel.data.currTime;
                
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    _commandGetHomePageDataFromLocal = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            HomeMainDataModel *homePageData = [DBManager getInstance].homePageData;
            
            NSMutableArray <BannerModel *>*bannerData = [NSMutableArray array];
            for(NSInteger i=0;i<homePageData.advert1Array.count;i++)
            {
                BannerModel *model = [[BannerModel alloc] init];
                model.imageUrl = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", homePageData.advert1Array[i].picPath, (NSInteger)(MAIN_SCREEN_WIDTH*2)];
                model.url = homePageData.advert1Array[i].url;
                
                [bannerData addObject:model];
            }
            ws.bannerData = bannerData;
            
            
            NSMutableArray <AdvertModel *>*adData2 = [NSMutableArray array];
            for(NSInteger i=0;i<homePageData.advert3Array.count;i++)
            {
                AdvertModel *model = [[AdvertModel alloc] init];
                model.title = homePageData.advert3Array[i].name;
                model.desc = homePageData.advert3Array[i].remark;
                model.imageUrl = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", homePageData.advert3Array[i].picPath, (NSInteger)(MAIN_SCREEN_WIDTH-30)];
                model.url = homePageData.advert3Array[i].url;
                
                [adData2 addObject:model];
            }
            ws.adData = adData2;
            
            ws.hotCities = homePageData.cities;
            ws.longRentCities = homePageData.longRentCities;
            ws.today = homePageData.currTime;
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            
            
            return nil;
        }];
        
        return signal;
    }];
}

@end
