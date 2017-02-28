//
//  XcleanViewController.m
//  xclean
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"

@implementation XbedViewController

- (instancetype)init
{
    if(self = [super init])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self config];
    [self addBaseView];
    [self setupNavigationBar];
    [self setupView];
    [self bindViewModel];
    [self handleEvent];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupPopGestureRecognizerEnable:YES];
}

- (void)setupPopGestureRecognizerEnable:(BOOL)enable
{
    self.navigationController.interactivePopGestureRecognizer.enabled = enable;
}

- (void)config
{
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = Background_Color;
}

- (void)addBaseView//解决scrollView的20像素偏移问题，不能让scrollView成为NavigationController的第一个视图
{
    self.baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 1)];
    [self.view addSubview:self.baseView];
}

- (void)setupNavigationBar
{
    
}

- (void)setupView
{
    
}

- (void)bindViewModel
{
    
}

- (void)handleEvent
{
    
}





- (void)back
{
    [[RootViewController getInstance] popViewControllerAnimated:YES];
}


#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}




- (void)dealloc
{
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"dealloc-%@", className);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    NSLog(@"内存警告！");
    
    if(self.isViewLoaded && !(self.view.window))
    {
        self.view = nil;
    }
}


@end
