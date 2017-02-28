//
//  ScreenConditionViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/7/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenConditionViewController.h"


@implementation ScreenConditionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.imgLeft = @"ic_turn_off";
    self.headView.txtRight = @"清空";
    self.headView.sizeLeft = CGSizeMake(19, 19);
    [self.view addSubview:self.headView];
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [[self.headView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws.priceView reset];
        [ws.typeView reset];
        [ws.bedView reset];
        [ws.characteristicView reset];
        
    }];
}

- (void)setupView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
    _priceView = [[RoomPriceSelectView alloc] initWithRentType:self.viewModel.rentType];
    [_scrollView addSubview:_priceView];
    [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(107);
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(0);
        
    }];
    _priceView.minPrice = self.viewModel.minPrice;
    _priceView.maxPrice = self.viewModel.maxPrice;
    
    
    
    
    _typeView = [[RoomTypeSelectView alloc] init];
    [_scrollView addSubview:_typeView];
    [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(93);
        make.top.mas_equalTo(_priceView.mas_bottom).offset(30);
        make.left.mas_equalTo(0);
        
    }];
    _typeView.roomTypes = self.viewModel.typeTags;
    _typeView.selectRoomTypes = self.viewModel.type;
    
    
    
    _bedView = [[RoomBedSelectView alloc] init];
    [_scrollView addSubview:_bedView];
    [_bedView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(_typeView.mas_bottom).offset(15);
        make.left.mas_equalTo(0);
        
    }];
    _bedView.roomBeds = self.viewModel.bedTags;
    _bedView.bedModel = self.viewModel.bed;
    
    
    _characteristicView = [[RoomCharacteristicSelectView alloc] init];
    [_scrollView addSubview:_characteristicView];
    [_characteristicView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(93);
        make.top.mas_equalTo(_bedView.mas_bottom).offset(30);
        make.left.mas_equalTo(0);
        
    }];
    _characteristicView.RoomCharacteristics = self.viewModel.characteristicTags;
    _characteristicView.selectRoomCharacteristics = self.viewModel.characteristic;
    
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_characteristicView.mas_bottom).offset(49);
        
    }];
    
    
    
    _btnSure = [[TouchView alloc] init];
    _btnSure.normalColor = Blue_Color;
    _btnSure.touchColor = Blue_Click_Color;
    [_btnSure setTitle:@"确定" forState:0];
    _btnSure.titleLabel.font = Font(16);
    [self.view addSubview:_btnSure];
    [_btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        
    }];
    
}

- (void)handleEvent
{
    WS(ws);
    
    [[_btnSure rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        ws.viewModel.minPrice = ws.priceView.minPrice;
        ws.viewModel.maxPrice = ws.priceView.maxPrice;
        
        ws.viewModel.type = ws.typeView.selectRoomTypes;
        
        ws.viewModel.bed = ws.bedView.bedModel;
        
        ws.viewModel.characteristic = ws.characteristicView.selectRoomCharacteristics;
        
        [ws dismissViewControllerAnimated:YES completion:nil];
        
    }];
}



















@end
