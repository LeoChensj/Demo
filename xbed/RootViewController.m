//
//  RootViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/7/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RootViewController.h"
#import "IntroductionView.h"
#import "HomeMainViewController.h"
#import "RubbishHomePageViewController.h"
#import "MyCollectionViewController.h"
#import "OrderListViewController.h"
#import "PersonalCenterViewController.h"
#import "TokenRequest.h"

@implementation RootViewController

+ (RootViewController *)getInstance
{
    static RootViewController *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[RootViewController alloc] init];
        
    });
    
    return instance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self hiddenNavigationBar];
    
    [self showAdPageView];
    
    [self setupTabBarViewController];
    
    if([DBManager isNewVersion])
    {
        [self showIntroduction];
    }
}

- (void)hiddenNavigationBar
{
    self.navigationBar.hidden = YES;
}

- (void)showAdPageView
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"adPagePic.plist"];
    UIImage *image = [LeoFileManager dataWithFilePath:filePath];
    
    if(image)
    {
        _adPageView = [[LeoAdPageView alloc] init];
        _adPageView.imgvAd.image = image;
        [self.view addSubview:_adPageView];
        [_adPageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(MAIN_SCREEN_HEIGHT);
            make.left.top.mas_equalTo(0);
            
        }];
    }
    
    
}

- (void)setupTabBarViewController
{
    if(_adPageView)
    {
        WS(ws);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [ws.adPageView close];
            
        });
    }
    
    RubbishHomePageViewController *vc11 = [[RubbishHomePageViewController alloc] init];
    //HomeMainViewController *vc1 = [[HomeMainViewController alloc] init];
    MyCollectionViewController *vc2 = [[MyCollectionViewController alloc] init];
    OrderListViewController *vc3 = [[OrderListViewController alloc] init];
    PersonalCenterViewController *vc4 = [[PersonalCenterViewController alloc] init];
    
    self.tabBarController = [CustomTabBarController getInstance];
    self.tabBarController.viewControllers = @[vc11, vc2, vc3, vc4];
    
    [self pushViewController:self.tabBarController animated:NO];
    
}

- (void)showIntroduction
{
    IntroductionView *introductionView = [[IntroductionView alloc] init];
    [self.view addSubview:introductionView];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
