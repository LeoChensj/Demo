//
//  RoomAddressViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomAddressViewModel.h"
#import "MapUtil.h"

@implementation RoomAddressViewModel

- (void)initProperty
{
    self.availableMaps = [NSMutableArray array];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandNavigate = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [ws.availableMaps removeAllObjects];
            
            CLLocationCoordinate2D startCoor = ws.userCoordinate;
            CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(ws.latitude.doubleValue, ws.longitude.doubleValue);
            NSString *toName = ws.address;
            
            
            //高德地图
            if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
            {
                NSString *gaodeParameterFormat = @"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&lat=%f&lon=%f&dev=1&style=2";
                NSString *urlString = [[NSString stringWithFormat:gaodeParameterFormat,
                                        @"xbed",
                                        @"xbed",
                                        toName,
                                        endCoor.latitude,
                                        endCoor.longitude]
                                       stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *dic = @{@"name": @"高德地图",
                                      @"url": urlString};
                [ws.availableMaps addObject:dic];
            }
            
            
            //百度地图
            if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
            {
                startCoor = [MapUtil mars2Bd:startCoor];
                endCoor = [MapUtil mars2Bd:endCoor];
                
                NSString *baiduParameterFormat = @"baidumap://map/direction?origin=%f,%f&destination=%f,%f&mode=driving";
                NSString *urlString = [[NSString stringWithFormat:baiduParameterFormat,
                                        startCoor.latitude,
                                        startCoor.longitude,
                                        endCoor.latitude,
                                        endCoor.longitude]
                                       stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
                
                
                NSDictionary *dic = @{@"name": @"百度地图",
                                      @"url": urlString};
                [ws.availableMaps addObject:dic];
            }
            
            
            //腾讯地图
            if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://map/"]])
            {
                NSString *QQParameterFormat = @"qqmap://map/routeplan?type=drive&from=%@&fromcoord=%f,%f&to=%@&tocoord=%f,%f&coord_type=1&policy=0&refer=%@";
                NSString *urlString = [[NSString stringWithFormat:QQParameterFormat,
                                        @"我的位置",
                                        startCoor.latitude,
                                        startCoor.longitude,
                                        toName,
                                        endCoor.latitude,
                                        endCoor.longitude,
                                        @"xbed"]
                                       stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *dic = @{@"name": @"腾讯地图",
                                      @"url": urlString};
                [ws.availableMaps addObject:dic];
            }
            
            
            //google地图
            if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
            {
                NSString *googleParameterFormat = @"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving";
                NSString *urlString = [[NSString stringWithFormat:googleParameterFormat,
                                        @"xbed",
                                        @"xbed",
                                        endCoor.latitude,
                                        endCoor.longitude]
                                       stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *dic = @{@"name": @"谷歌地图",
                                      @"url": urlString};
                [ws.availableMaps addObject:dic];
            }
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            
            return nil;
        }];
        
        return signal;
    }];
    
    
}

@end
