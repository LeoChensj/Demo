//
//  RoomAddressViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "RoomAddressViewModel.h"
#import "RoomAddressMapView.h"
#import "RoomAddressButtonView.h"

@interface RoomAddressViewController : XbedViewController <UIActionSheetDelegate>

@property (nonatomic, strong, readonly)RoomAddressMapView *mapView;
@property (nonatomic, strong, readonly)RoomAddressButtonView *buttonView;

@property (nonatomic, strong)RoomAddressViewModel *viewModel;

@end
