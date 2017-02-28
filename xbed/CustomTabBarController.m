//
//  CustomTabBarController.m
//  xbed
//
//  Created by Leo.Chen on 16/7/5.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CustomTabBarController.h"

@implementation CustomTabBarItem

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _imgvIcon = [[UIImageView alloc] init];
        [self addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(24);
            make.height.mas_equalTo(24);
            make.centerX.mas_equalTo(self.mas_centerX).offset(0);
            make.top.mas_equalTo(5);
            
        }];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = Font(10);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(10);
            make.centerX.mas_equalTo(self.mas_centerX).offset(0);
            make.bottom.mas_equalTo(-4);
            
        }];
        
        _vBadge = [[UIView alloc] init];
        _vBadge.layer.masksToBounds = YES;
        _vBadge.layer.cornerRadius = 4;
        _vBadge.backgroundColor = Red_Color;
        [self addSubview:_vBadge];
        [_vBadge mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(8);
            make.left.mas_equalTo(_imgvIcon.mas_right).offset(0);
            make.bottom.mas_equalTo(_imgvIcon.mas_top).offset(5);
            
        }];
    }
    
    return self;
}

- (void)setImgNormal:(UIImage *)imgNormal
{
    _imgNormal = imgNormal;
    
    if(_isSelect==NO)
    {
        _imgvIcon.image = imgNormal;
    }
}
- (void)setImgSelect:(UIImage *)imgSelect
{
    _imgSelect = imgSelect;
    
    if(_isSelect)
    {
        _imgvIcon.image = imgSelect;
    }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}
- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    
    if(isSelect)
    {
        _imgvIcon.image = _imgSelect;
        _lbTitle.textColor = Blue_Color;
    }
    else
    {
        _imgvIcon.image = _imgNormal;
        _lbTitle.textColor = Secondary_Text_Color;
    }
}
- (void)setIsNotice:(BOOL)isNotice
{
    _isNotice = isNotice;
    
    _vBadge.hidden = !isNotice;
}

@end




@implementation CustomTabBarController

+ (CustomTabBarController *)getInstance
{
    static CustomTabBarController *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[CustomTabBarController alloc] init];
        
    });
    
    return instance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self hideRealTabBar];
    [self customTabBar];
}

- (void)hideRealTabBar
{
    [self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条
}

- (void)customTabBar
{
    _vTabBarBack = [[UIView alloc] init];
    _vTabBarBack.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_vTabBarBack];
    [_vTabBarBack mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(48);
        make.left.bottom.mas_equalTo(0);
        
    }];
    
    //*****毛玻璃*****//
    if(More_iOS8)
    {
        _vTabBarBack.backgroundColor = [UIColor clearColor];
        
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] init];
        effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        [_vTabBarBack addSubview:effectView];
        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(48);
            make.left.top.mas_equalTo(0);
            
        }];
    }
    //*****毛玻璃*****//
    
    
    
    
    NSArray *normalImages = @[[UIImage imageNamed:@"ic_dock_index"],
                              [UIImage imageNamed:@"ic_dock_collect"],
                              [UIImage imageNamed:@"ic_dock_orders"],
                              [UIImage imageNamed:@"ic_dock_mine"]];
    NSArray *selectImages = @[[UIImage imageNamed:@"ic_dock_index_select"],
                              [UIImage imageNamed:@"ic_dock_collect_select"],
                              [UIImage imageNamed:@"ic_dock_orders_select"],
                              [UIImage imageNamed:@"ic_dock_mine_select"]];
    NSArray *titles = @[@"首页", @"收藏", @"订单", @"我的"];
    
    _tabBarItems = [NSMutableArray array];
    for (NSInteger i=0;i<4;i++)
    {
        CGFloat itemWidth = MAIN_SCREEN_WIDTH/4;
        
        CustomTabBarItem *item = [[CustomTabBarItem alloc] init];
        item.tag = 156+i;
        item.imgNormal = normalImages[i];
        item.imgSelect = selectImages[i];
        item.title = titles[i];
        item.isNotice = NO;
        item.isSelect = NO;
        [_vTabBarBack addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(48);
            make.left.mas_equalTo(i*itemWidth);
            make.top.mas_equalTo(0);
            
        }];
        
        WS(ws);
        [[item rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(CustomTabBarItem *x) {
            
            NSInteger index = x.tag-156;
            
            ws.index = index;
            
        }];
        
        [_tabBarItems addObject:item];
    }
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = Secondary_Text_Color2;
    [_vTabBarBack addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(LINE_WIDTH);
        make.left.top.mas_equalTo(0);
        
    }];
    
    
    self.index = TabBarIndexHome;
}

- (void)setIndex:(TabBarIndex)index
{
    _index = index;
    
    self.selectedIndex = index;
    
    for (NSInteger i=0;i<4;i++)
    {
        if(i==(NSInteger)index)
        {
            _tabBarItems[i].isSelect = YES;
        }
        else
        {
            _tabBarItems[i].isSelect = NO;
        }
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
