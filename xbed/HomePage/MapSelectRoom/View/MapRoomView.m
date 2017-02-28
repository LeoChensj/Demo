//
//  MapRoomView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "MapRoomView.h"

@implementation MapRoomView

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-64)])
    {
        self.mapType = MAMapTypeStandard;
        self.showsUserLocation = YES;
        self.userTrackingMode = MAUserTrackingModeNone;
        self.showsScale = NO;
        self.showsCompass = NO;
        self.delegate = self;
        
        _btnLocate = [[UIButton alloc] init];
        [_btnLocate setImage:[UIImage imageNamed:@"ic_lacation"] forState:UIControlStateNormal];
        [_btnLocate setImage:[UIImage imageNamed:@"ic_lacation"] forState:UIControlStateHighlighted];
        [self addSubview:_btnLocate];
        [_btnLocate mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(44);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-20);
            
        }];
        WS(ws);
        [[_btnLocate rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws locateToMyPosition];
            
        }];
        
        
        
    }
    
    return self;
}


#pragma mark - Help
- (void)locateToMyPosition
{
    MACoordinateSpan span = MACoordinateSpanMake(0.125, 0.125);
    MACoordinateRegion region = MACoordinateRegionMake(_userCoordinate, span);
    [self setRegion:region animated:YES];
    
    self.userTrackingMode = MAUserTrackingModeFollow;
}




#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation && !_isLocateSuccess)
    {
        _isLocateSuccess = YES;
        
        _userCoordinate = userLocation.coordinate;
        
        
        //模拟
        RoomPricePointAnnotation *annotation1 = [[RoomPricePointAnnotation alloc] init];
        AroundRoomModel *model1 = [[AroundRoomModel alloc] init];
        model1.roomId = @1;
        model1.price = @168;
        model1.latitude = @23.0742;
        model1.longitude = @113.24371256510416;
        annotation1.model = model1;
        
        RoomPricePointAnnotation *annotation2 = [[RoomPricePointAnnotation alloc] init];
        AroundRoomModel *model2 = [[AroundRoomModel alloc] init];
        model2.roomId = @2;
        model2.price = @268;
        model2.latitude = @23.1142;
        model2.longitude = @113.24371256510416;
        annotation2.model = model2;
        
        [self addAnnotations:@[annotation1, annotation2]];
        
        [self locateToMyPosition];
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        RoomPriceAnnotationView *annotationView = (RoomPriceAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        
        if (annotationView==nil)
        {
            annotationView = [[RoomPriceAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        
        RoomPricePointAnnotation *priceAnnotation = (RoomPricePointAnnotation *)annotation;
        annotationView.price = priceAnnotation.model.price;
        
        return annotationView;
    }
    
    return nil;
}
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"select");
    [view setSelected:YES];
}
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    NSLog(@"deselect");
    [view setSelected:NO];
}




@end
