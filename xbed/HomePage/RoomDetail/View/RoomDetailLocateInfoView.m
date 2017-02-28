//
//  RoomDetailLocateInfoView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailLocateInfoView.h"

#define RoomDetailMapViewHeight MAIN_SCREEN_WIDTH*0.6

@implementation RoomDetailLocateInfoView

@synthesize button = _button;

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, RoomDetailMapViewHeight)];
        //_mapView.delegate = self;
        _mapView.mapType = MAMapTypeStandard;
        _mapView.showsUserLocation = NO;
        _mapView.userTrackingMode = MAUserTrackingModeNone;
        _mapView.showsScale = NO;
        _mapView.showsCompass = NO;
        _mapView.zoomEnabled = NO;
        _mapView.rotateEnabled = NO;
        _mapView.scrollEnabled = NO;
        _mapView.rotateCameraEnabled = NO;
        _mapView.skyModelEnable = NO;
        [self addSubview:_mapView];
        [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(RoomDetailMapViewHeight);
            make.top.left.mas_equalTo(0);
            
        }];
        
        
        _vContent = [[UIView alloc] init];
        _vContent.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vContent];
        [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(33);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(RoomDetailMapViewHeight);
            
        }];
        
        
        _imgvIcon = [[UIImageView alloc] init];
        _imgvIcon.image = [UIImage imageNamed:@"ic_distance"];
        [_vContent addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(11);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"详细地址：";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(13);
        [_vContent addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(_imgvIcon.mas_right).offset(7);
            make.top.mas_equalTo(11);
            
        }];
        
        
        _lbAddress = [[UILabel alloc] init];
        _lbAddress.numberOfLines = 0;
        _lbAddress.textColor = Main_Text_Color;
        _lbAddress.font = Font(13);
        [_vContent addSubview:_lbAddress];
        [_lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-103-15);
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(103);
            make.top.mas_equalTo(10);
            
        }];
        
        
        
        WS(ws);
        
        [[RACSignal combineLatest:@[RACObserve(self, latitude), RACObserve(self, longitude)] reduce:^id(NSNumber *latitude, NSNumber *longitude){
            
            return @(latitude && longitude);
            
        }] subscribeNext:^(NSNumber *x) {
            
            if(x.boolValue)
            {
                NSLog(@"coordinate1=(%f, %f)", ws.latitude.doubleValue, ws.longitude.doubleValue);
                
                MACoordinateSpan span = MACoordinateSpanMake(0.01, 0.01);
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(ws.latitude.doubleValue, ws.longitude.doubleValue);
                MACoordinateRegion region = MACoordinateRegionMake(coordinate, span);
                [ws.mapView setRegion:region animated:NO];
                
                
                MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
                annotation.coordinate = CLLocationCoordinate2DMake(ws.latitude.doubleValue, ws.longitude.doubleValue);
                [ws.mapView addAnnotation:annotation];
                
            }
            
        }];
        
    }
    
    return self;
}


/*
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            annotationView.image = [UIImage imageNamed:@"ic_detail_distance"];
        }
        
        return annotationView;
    }
    return nil;
}
*/




- (UIButton *)button
{
    if(_button==nil)
    {
        _button = [[UIButton alloc] init];
        [self addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(RoomDetailMapViewHeight);
            make.left.top.mas_equalTo(0);
            
        }];
    }
    
    return _button;
}



- (void)setAddress:(NSString *)address
{
    _address = address;
    
    if(address)
    {
        self.hidden = NO;
        
        _lbAddress.text = address;
        
        CGSize sizeAddress = [_lbAddress labelSize:(MAIN_SCREEN_WIDTH-103-15)];
        
        [_lbAddress mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(sizeAddress.height);
            
        }];
        
        [_vContent mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(10+sizeAddress.height+10);
            
        }];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(RoomDetailMapViewHeight+10+sizeAddress.height+10);
            
        }];
    }
    else
    {
        self.hidden = NO;
    }
}










@end
