//
//  RoomAddressViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomAddressViewController.h"
#import "ShowAllInfoView.h"
#import "VillageNavigationViewController.h"

@implementation RoomAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.imgLeft = @"ic_back";
    self.headView.title = @"房间地址";
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _mapView = [[RoomAddressMapView alloc] init];
    [self.view addSubview:_mapView];
    
    _buttonView = [[RoomAddressButtonView alloc] init];
    [self.view addSubview:_buttonView];
    [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(54);
        make.left.bottom.mas_equalTo(0);
        
    }];
    
}

- (void)bindViewModel
{
    RAC(_mapView, latitude) = RACObserve(self.viewModel, latitude);
    RAC(_mapView, longitude) = RACObserve(self.viewModel, longitude);
    RAC(_mapView, address) = RACObserve(self.viewModel, address);
    RAC(self.viewModel, userCoordinate) = RACObserve(_mapView, userCoordinate);
}

- (void)handleEvent
{
    WS(ws);
    [[_buttonView.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"导航-(%f, %f)", ws.viewModel.userCoordinate.latitude, ws.viewModel.userCoordinate.longitude);
        
        [[ws.viewModel.commandNavigate execute:nil] subscribeNext:^(id x) {
            
            UIActionSheet *action = [[UIActionSheet alloc] init];
            action.delegate = ws;
            [action addButtonWithTitle:@"使用系统自带地图导航"];
            for (NSDictionary *dic in ws.viewModel.availableMaps)
            {
                [action addButtonWithTitle:[NSString stringWithFormat:@"使用%@导航", dic[@"name"]]];
            }
            [action addButtonWithTitle:@"取消"];
            action.cancelButtonIndex = ws.viewModel.availableMaps.count + 1;
            [action showInView:ws.view];
            
        }];
        
    }];
    
    [[_buttonView.button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"小区导航");
        
        VillageNavigationViewModel *viewModel = [[VillageNavigationViewModel alloc] init];
        viewModel.imageNavigation = ws.viewModel.imageNavigation;
        PushVCWithVM(VillageNavigationViewController, viewModel);
        
    }];
    
    [[_buttonView.button3 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        ShowAllInfoView *infoView = [[ShowAllInfoView alloc] initWithContentHeight:295];
        infoView.title = @"停车信息";
        infoView.contentArray = ws.viewModel.parkInfo;
        [ws.view addSubview:infoView];
        
    }];
    
}




#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //CLLocationCoordinate2D startCoor = self.viewModel.userCoordinate;
        CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(self.viewModel.latitude.doubleValue, self.viewModel.longitude.doubleValue);
        
        // 直接调用ios自己带的apple map
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
        toLocation.name = self.viewModel.address;
        
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        
    }
    else if (buttonIndex < self.viewModel.availableMaps.count+1)
    {
        NSDictionary *mapDic = self.viewModel.availableMaps[buttonIndex-1];
        NSString *urlString = mapDic[@"url"];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}



- (RoomAddressViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[RoomAddressViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}


@end
