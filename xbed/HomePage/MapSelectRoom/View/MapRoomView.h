//
//  MapRoomView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "RoomPricePointAnnotation.h"
#import "RoomPriceAnnotationView.h"

@interface MapRoomView : MAMapView <MAMapViewDelegate>
{
@private
    UIButton *_btnLocate;
    BOOL _isLocateSuccess;
    CLLocationCoordinate2D _userCoordinate;//用户定位经纬度
}

@property (nonatomic, strong)NSArray *annotationss;

@end
