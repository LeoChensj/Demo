//
//  HomeMainViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/7/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomeMainViewModel.h"

@implementation HomeMainViewModel

- (void)setupSignal
{
    _signalCityData = [RACSignal combineLatest:@[RACObserve(self, cityData)] reduce:^id(NSArray <HomeMainModel *>*cityData){
        
        return @(!(cityData && cityData.count>0));
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    _commandGetData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            HomeMainRequestModel *model = [[HomeMainRequestModel alloc] init];
            HomeMainRequest *request = [[HomeMainRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                HomeMainRespModel *respModel = [request responseModel];
                
                NSMutableArray <BannerModel *>*bannerData = [NSMutableArray array];
                for(NSInteger i=0;i<respModel.data.advert1Array.count;i++)
                {
                    BannerModel *model = [[BannerModel alloc] init];
                    model.imageUrl = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", respModel.data.advert1Array[i].picPath, (NSInteger)(MAIN_SCREEN_WIDTH*2)];
                    model.url = respModel.data.advert1Array[i].url;
                    
                    [bannerData addObject:model];
                }
                ws.bannerData = bannerData;
                
                
                NSMutableArray <AdvertModel *>*adData1 = [NSMutableArray array];
                for(NSInteger i=0;i<respModel.data.advert2Array.count;i++)
                {
                    AdvertModel *model = [[AdvertModel alloc] init];
                    model.title = respModel.data.advert2Array[i].name;
                    model.desc = respModel.data.advert2Array[i].remark;
                    model.imageUrl = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", respModel.data.advert2Array[i].picPath, (NSInteger)((MAIN_SCREEN_WIDTH-20)*2)];
                    model.url = respModel.data.advert2Array[i].url;
                    
                    [adData1 addObject:model];
                }
                ws.adData1 = adData1;
                
                
                NSArray <HomeMainModel *>*cityArray = respModel.data.advert4Array;
                for (NSInteger i=0;i<cityArray.count;i++)
                {
                    cityArray[i].picPath = [NSString stringWithFormat:@"%@?imageView2/2/w/%ld", cityArray[i].picPath, (NSInteger)(MAIN_SCREEN_WIDTH*2)];
                }
                ws.cityData = cityArray;
                
                
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
                ws.adData2 = adData2;
                
                
                
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
}

@end
