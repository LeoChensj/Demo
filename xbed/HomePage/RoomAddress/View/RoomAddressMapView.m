//
//  RoomAddressMapView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomAddressMapView.h"
#import "RoomAddressAnnotationView.h"
#import "RoomAddressPointAnnotation.h"

@implementation RoomAddressMapView

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
        
        
        
        WS(ws);
        [[RACSignal combineLatest:@[RACObserve(self, latitude), RACObserve(self, longitude), RACObserve(self, address)] reduce:^id(NSNumber *latitude, NSNumber *longitude, NSString *address){
            
            return @(latitude && longitude && address.length);
            
        }] subscribeNext:^(NSNumber *x) {
            
            if(x.boolValue)
            {
                NSLog(@"coordinate2=(%f, %f)", ws.latitude.doubleValue, ws.longitude.doubleValue);
                
                MACoordinateSpan span = MACoordinateSpanMake(0.125, 0.125);
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(ws.latitude.doubleValue, ws.longitude.doubleValue);
                MACoordinateRegion region = MACoordinateRegionMake(coordinate, span);
                [ws setRegion:region animated:YES];
                
                RoomAddressPointAnnotation *annotation = [[RoomAddressPointAnnotation alloc] init];
                annotation.address = ws.address;
                annotation.coordinate = CLLocationCoordinate2DMake(ws.latitude.doubleValue, ws.longitude.doubleValue);
                [ws addAnnotation:annotation];
            }
            
        }];
        
    }
    
    return self;
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        NSLog(@"定位成功");
        
        self.userCoordinate = userLocation.coordinate;
        
        self.showsUserLocation = NO;
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        RoomAddressAnnotationView *annotationView = (RoomAddressAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        
        if (annotationView==nil)
        {
            annotationView = [[RoomAddressAnnotationView alloc] initWithAnnotation:annotation
                                                                 reuseIdentifier:reuseIndetifier];
        }
        
        RoomAddressPointAnnotation *addressAnnotation = (RoomAddressPointAnnotation *)annotation;
        annotationView.address = addressAnnotation.address;
        
        return annotationView;
    }
    
    return nil;
}




@end
