//
//  RoomEvaluateViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluateViewController.h"
#import "RoomDetailViewController.h"
#import "CheckinInfoConfirmViewController.h"

@implementation RoomEvaluateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupNavigationBar
{
    self.headView = [[HeadView alloc] init];
    self.headView.title = @"房间评价";
    self.headView.imgLeft = @"ic_back";
    [self.view addSubview:self.headView];
    
    WS(ws);
    [[self.headView.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
}

- (void)setupView
{
    _scrollView = [[TouchEventScrollView alloc] init];
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    
    
    _baseInfoView = [[RoomEvaluateBaseInfoView alloc] init];
    [_scrollView addSubview:_baseInfoView];
    [_baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(134*2/3+20);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        
    }];
    _baseInfoView.roomImage = self.viewModel.roomInfo.picture;
    _baseInfoView.title = self.viewModel.roomInfo.custRoomName;
    if(self.viewModel.roomInfo.roomFloor)
    {
        _baseInfoView.roomAddress = [NSString stringWithFormat:@"%@楼%@", self.viewModel.roomInfo.roomFloor, self.viewModel.roomInfo.custRoomNo];
    }
    else
    {
        _baseInfoView.roomAddress = self.viewModel.roomInfo.custRoomNo;
    }
    
}

- (void)bindViewModel
{
    
}

- (void)handleEvent
{
    WS(ws);
    
    [RACObserve(self.viewModel, roomEvaluateState) subscribeNext:^(NSNumber *x) {
        
        if(x)
        {
            if(x.integerValue==1)//待评价
            {
                ws.headView.txtRight = @"提交";
                ws.headView.btnRight.enabled = YES;
                
                [ws.scrollView addSubview:ws.roomStarView];
                [ws.roomStarView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(92);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.baseInfoView.mas_bottom).offset(0);
                    
                }];
                ws.roomStarView.title = @"房间评分";
                ws.roomStarView.enable = YES;
                ws.roomStarView.starTerm = ws.viewModel.waitEvaluateData.roomStarTerm;
                
                [ws.scrollView addSubview:ws.cleanStarView];
                [ws.cleanStarView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(92+30);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.roomStarView.mas_bottom).offset(0);
                    
                }];
                ws.cleanStarView.title = @"清洁评分";
                ws.cleanStarView.enable = YES;
                ws.cleanStarView.starTerm = ws.viewModel.waitEvaluateData.cleanStarTerm;
                
                [ws.scrollView addSubview:ws.evaluateInputView];
                [ws.evaluateInputView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(134);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.cleanStarView.mas_bottom).offset(10);
                    
                }];
                
                
                [ws.scrollView addSubview:ws.evaluatePhotoSelectView];
                [ws.evaluatePhotoSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(189);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.evaluateInputView.mas_bottom).offset(10);
                    
                }];
                
                [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.mas_equalTo(ws.evaluatePhotoSelectView.mas_bottom).offset(10);
                    
                }];
                
                
            }
            else if(x.integerValue==2)//已评价
            {
                ws.headView.txtRight = nil;
                ws.headView.btnRight.enabled = NO;
                
                [ws.scrollView addSubview:ws.roomStarView];
                [ws.roomStarView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(92);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.baseInfoView.mas_bottom).offset(0);
                    
                }];
                ws.roomStarView.title = @"房间评分";
                ws.roomStarView.enable = NO;
                ws.roomStarView.star = ws.viewModel.evaluatedData.roomStar;
                ws.roomStarView.termList = ws.viewModel.evaluatedData.roomTermList;
                
                [ws.scrollView addSubview:ws.cleanStarView];
                [ws.cleanStarView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(92+30);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.roomStarView.mas_bottom).offset(0);
                    
                }];
                ws.cleanStarView.title = @"清洁评分";
                ws.cleanStarView.enable = NO;
                ws.cleanStarView.star = ws.viewModel.evaluatedData.cleanStar;
                ws.cleanStarView.termList = ws.viewModel.evaluatedData.cleanTermList;
                
                [ws.scrollView addSubview:ws.evaluateContentView];
                [ws.evaluateContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(0);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.cleanStarView.mas_bottom).offset(0);
                    
                }];
                ws.evaluateContentView.content = ws.viewModel.evaluatedData.content;

                [ws.scrollView addSubview:ws.evaluatedPhotoView];
                [ws.evaluatedPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(0);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.evaluateContentView.mas_bottom).offset(0);
                    
                }];
                ws.evaluatedPhotoView.dataArray = ws.viewModel.evaluatedData.picList;
                
                [ws.scrollView addSubview:ws.nearbyRoomView];
                [ws.nearbyRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(70+((MAIN_SCREEN_WIDTH-96)*2/3)+98);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.evaluatedPhotoView.mas_bottom).offset(10);
                    
                }];
                ws.nearbyRoomView.dataArray = ws.viewModel.nearbyRoomData;
                
                [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.mas_equalTo(ws.nearbyRoomView.mas_bottom).offset(49);
                    
                }];
                
                
                [ws.view addSubview:ws.btnBook];
                [ws.btnBook mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(49);
                    make.left.mas_equalTo(0);
                    make.bottom.mas_equalTo(0);
                    
                }];
                
            }
            else if(x.integerValue==3)//评价过期
            {
                ws.headView.txtRight = nil;
                ws.headView.btnRight.enabled = NO;
                
                [ws.scrollView addSubview:ws.evaluateOverdueStarView];
                [ws.evaluateOverdueStarView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(163);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.baseInfoView.mas_bottom).offset(10);
                    
                }];
                
                [ws.scrollView addSubview:ws.nearbyRoomView];
                [ws.nearbyRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(70+((MAIN_SCREEN_WIDTH-96)*2/3)+98);
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(ws.evaluateOverdueStarView.mas_bottom).offset(10);
                    
                }];
                ws.nearbyRoomView.dataArray = ws.viewModel.nearbyRoomData;
                
                [ws.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.mas_equalTo(ws.nearbyRoomView.mas_bottom).offset(49);
                    
                }];
                
                
                [ws.view addSubview:ws.btnBook];
                [ws.btnBook mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
                    make.height.mas_equalTo(49);
                    make.left.mas_equalTo(0);
                    make.bottom.mas_equalTo(0);
                    
                }];
                
            }
        }
        
    }];
    
    
    
    [[self.viewModel.commandGetData execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [ws back];
        }
        
    }];
    
    
    [[_baseInfoView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        RoomDetailViewModel *viewModel = [[RoomDetailViewModel alloc] init];
        viewModel.roomId = ws.viewModel.roomId;
        PushVCWithVM(RoomDetailViewController, viewModel);
        
    }];
    
    
    
    //提交评价
    [[self.headView.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        ws.viewModel.subRoomStarId = ws.roomStarView.starId;
        ws.viewModel.subRoomTermIdList = ws.roomStarView.selectTags;
        ws.viewModel.subCleanStarId = ws.cleanStarView.starId;
        ws.viewModel.subCleanTermIdList = ws.cleanStarView.selectTags;
        ws.viewModel.subContent = ws.evaluateInputView.content;
        ws.viewModel.subPicDataList = ws.evaluatePhotoSelectView.datas;
        
        [[ws.viewModel.commandSubmit execute:nil] subscribeNext:^(NSString *x) {
            
            if(x && x.length)
            {
                [ws.view makeToast:x];
            }
            else
            {
                [[UIApplication sharedApplication].keyWindow makeToast:@"评价成功"];
                
                CheckinOrderInfoDataModel *checkinOrderInfo = ws.viewModel.orderDetailViewModel.checkinOrderInfo;
                checkinOrderInfo.type = @9;
                checkinOrderInfo.evaluated = ws.viewModel.evaluatedData;
                
                ws.viewModel.orderDetailViewModel.checkinOrderInfo = checkinOrderInfo;
                
                [ws back];
            }
            
        }];
        
    }];
    
    
    [[self.btnBook rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        if(ws.viewModel.roomInfo.flag.integerValue==1)
        {
            CheckinInfoConfirmViewModel *viewModel = [[CheckinInfoConfirmViewModel alloc] init];
            viewModel.rentType = ws.viewModel.rentType.integerValue-1;
            viewModel.type = 0;
            viewModel.roomId = ws.viewModel.roomId;
            viewModel.roomImage = ws.viewModel.roomInfo.picture;
            viewModel.title = ws.viewModel.roomInfo.custRoomName;
            viewModel.roomType = ws.viewModel.roomInfo.houseType;
            viewModel.person = ws.viewModel.roomInfo.liveCount;
            PushVCWithVM(CheckinInfoConfirmViewController, viewModel);
        }
        else
        {
            ws.alertView = [[STAlertView alloc] initWithTitle:@"系统提示" message:@"对不起，该房间已下架" cancelButtonTitle:@"知道了" otherButtonTitle:nil cancelButtonBlock:nil otherButtonBlock:nil];
            [ws.alertView show];
        }
        
    }];
    
}






- (RoomEvaluateStarView *)roomStarView
{
    if(_roomStarView==nil)
    {
        _roomStarView = [[RoomEvaluateStarView alloc] init];
    }
    
    return _roomStarView;
}

- (RoomEvaluateStarView *)cleanStarView
{
    if(_cleanStarView==nil)
    {
        _cleanStarView = [[RoomEvaluateStarView alloc] init];
    }
    
    return _cleanStarView;
}

- (EvaluateInputView *)evaluateInputView
{
    if(_evaluateInputView==nil)
    {
        _evaluateInputView = [[EvaluateInputView alloc] init];
    }
    
    return _evaluateInputView;
}

- (EvaluatePhotoView *)evaluatePhotoSelectView
{
    if(_evaluatePhotoSelectView==nil)
    {
        _evaluatePhotoSelectView = [[EvaluatePhotoView alloc] initWithViewController:self];
    }
    
    return _evaluatePhotoSelectView;
}

- (RoomEvaluateContentView *)evaluateContentView
{
    if(_evaluateContentView==nil)
    {
        _evaluateContentView = [[RoomEvaluateContentView alloc] init];
    }
    
    return _evaluateContentView;
}

- (RoomEvaluatePhotoView *)evaluatedPhotoView
{
    if(_evaluatedPhotoView==nil)
    {
        _evaluatedPhotoView = [[RoomEvaluatePhotoView alloc] init];
    }
    
    return _evaluatedPhotoView;
}

- (RoomDetailNearbyRoomView *)nearbyRoomView
{
    if(_nearbyRoomView==nil)
    {
        _nearbyRoomView = [[RoomDetailNearbyRoomView alloc] init];
        
        [_nearbyRoomView addRoomDetailNearbyRoomViewDidSelectItemBlock:^(RoomDetailNearbyRoomView *view, NearbyRoomModel *model, NSInteger index) {
            
            RoomDetailViewModel *viewModel = [[RoomDetailViewModel alloc] init];
            viewModel.roomId = model.roomId;
            PushVCWithVM(RoomDetailViewController, viewModel);
            
        }];
    }
    
    return _nearbyRoomView;
}

- (EvaluateOverdueStarView *)evaluateOverdueStarView
{
    if(_evaluateOverdueStarView==nil)
    {
        _evaluateOverdueStarView = [[EvaluateOverdueStarView alloc] init];
    }
    
    return _evaluateOverdueStarView;
}




- (BlueButton *)btnBook
{
    if(_btnBook==nil)
    {
        _btnBook = [[BlueButton alloc] init];
        _btnBook.title = @"再次预订";
        _btnBook.enabled = YES;
    }
    
    return _btnBook;
}




- (RoomEvaluateViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[RoomEvaluateViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}

@end
