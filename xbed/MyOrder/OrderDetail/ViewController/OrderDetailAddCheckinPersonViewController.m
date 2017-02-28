//
//  OrderDetailAddCheckinPersonViewController.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailAddCheckinPersonViewController.h"
#import "ShareOrderView.h"

@implementation OrderDetailAddCheckinPersonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"添加入住人";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    _btnAddCheckinPerson = [[TouchView alloc] init];
    _btnAddCheckinPerson.normalColor = [UIColor whiteColor];
    _btnAddCheckinPerson.touchColor = White_Click_COLOR;
    [_scrollView addSubview:_btnAddCheckinPerson];
    [_btnAddCheckinPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(10);
        
    }];
    
    UILabel *lbAddPerson = [[UILabel alloc] init];
    lbAddPerson.text = @"添加入住人";
    lbAddPerson.textColor = Main_Text_Color;
    lbAddPerson.font = Font(13);
    [_btnAddCheckinPerson addSubview:lbAddPerson];
    [lbAddPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(13);
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(10);
        
    }];
    
    
    UILabel *lbAddPersonRemind = [[UILabel alloc] init];
    lbAddPersonRemind.text = @"（被添加人可看到该订单，并办理入住）";
    lbAddPersonRemind.textColor = Red_Color;
    lbAddPersonRemind.font = Font(13);
    [_btnAddCheckinPerson addSubview:lbAddPersonRemind];
    [lbAddPersonRemind mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH-10-70-30);
        make.height.mas_equalTo(13);
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(lbAddPerson.mas_right).offset(0);
        
    }];
    
    UIImageView *imgvAddInto = [[UIImageView alloc] init];
    imgvAddInto.image = [UIImage imageNamed:@"ic_search_into"];
    [_btnAddCheckinPerson addSubview:imgvAddInto];
    [imgvAddInto mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(14);
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = Seg_Line_Color;
    [_btnAddCheckinPerson addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(LINE_WIDTH);
        make.left.bottom.mas_equalTo(0);
        
    }];
    
    
    
    _checkinPersonListView = [[CheckinPersonListView alloc] init];
    [_scrollView addSubview:_checkinPersonListView];
    [_checkinPersonListView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(100);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_btnAddCheckinPerson.mas_bottom).offset(0);
        
    }];
    
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_checkinPersonListView.mas_bottom).offset(0);
        
    }];
}

- (void)bindViewModel
{
    RAC(_checkinPersonListView, dataArray) = RACObserve(self.viewModel, checkinOrderInfo.checkinerList);
}

- (void)handleEvent
{
    WS(ws);
    
    [[_btnAddCheckinPerson rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSString* strUrl = ws.viewModel.checkinOrderInfo.roomInfo.picture;
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:strUrl]];
        SDImageCache* cache = [SDImageCache sharedImageCache];
        UIImage *roomImage = [cache imageFromDiskCacheForKey:key];
        
        ShareOrderView *shareOrderView = [[ShareOrderView alloc] init];
        shareOrderView.viewController = ws;
        shareOrderView.image = roomImage;
        shareOrderView.desc = ws.viewModel.checkinOrderInfo.roomInfo.custRoomName;
        shareOrderView.url = ws.viewModel.checkinOrderInfo.shareUrl;
        [shareOrderView show];
        
    }];
}







- (OrderDetailViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[OrderDetailViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
