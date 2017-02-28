//
//  RoomDetailLocateInfoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface RoomDetailLocateInfoView : UIView //<MAMapViewDelegate>
{
@private
    UIImageView *_imgvIcon;
    UIView *_vContent;
    UILabel *_lbTitle;
    UILabel *_lbAddress;
}

@property (nonatomic, strong, readonly)MAMapView *mapView;
@property (nonatomic, strong, readonly)UIButton *button;

@property (nonatomic, strong)NSNumber *latitude;
@property (nonatomic, strong)NSNumber *longitude;
@property (nonatomic, strong)NSString *address;


@end
