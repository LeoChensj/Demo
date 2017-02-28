//
//  RoomDetailViewController.m
//  xbed
//
//  Created by Leo.Chen on 16/8/3.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailViewController.h"
#import "ShowAllInfoView.h"
#import "ShowAllInfoView2.h"
#import "RoomAddressViewController.h"
#import "RoomEvaluateListViewController.h"
#import "CheckinInfoConfirmViewController.h"
#import "BKPhotoBrowser.h"
#import "ShareView.h"
#import "LoginViewController.h"


@implementation RoomDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_roomImagesView startTimer];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_roomImagesView stopTimer];
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
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT);
        make.left.top.mas_equalTo(0);
        
    }];
    //_scrollView.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH, 4000);
    
    
    _roomImagesView = [[RoomImagesView alloc] init];
    [_scrollView addSubview:_roomImagesView];
    
    
    _priceView = [[PriceView alloc] init];
    [_roomImagesView addSubview:_priceView];
    [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(39);
        make.left.mas_equalTo(-5);
        make.bottom.mas_equalTo(-15);
        
    }];
    _priceView.rentType = self.viewModel.rentType;
    
    
    _headView1 = [[RoomDetailHeadView1 alloc] init];
    [self.view addSubview:_headView1];
    [_headView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(64);
        make.left.top.mas_equalTo(0);
        
    }];
    
    _headView2 = [[RoomDetailHeadView2 alloc] init];
    [self.view addSubview:_headView2];
    [_headView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(64);
        make.left.top.mas_equalTo(0);
        
    }];
    
    _titleTagsView = [[RoomDetailTitleTagsView alloc] initWithRentType:self.viewModel.rentType];
    [_scrollView addSubview:_titleTagsView];
    [_titleTagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(100);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(RoomImagesViewHeight);
        
    }];
    
    
    _baseInfoView = [[RoomDetailBaseInfoView alloc] init];
    [_scrollView addSubview:_baseInfoView];
    [_baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_titleTagsView.mas_bottom).offset(0);
        
    }];
    
    
    
    _remindView = [[RoomDetailRemindView alloc] init];
    [_scrollView addSubview:_remindView];
    [_remindView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_baseInfoView.mas_bottom).offset(0);
        
    }];
    
    
    _calendarView = [[RoomDetailCalendarView alloc] init];
    [_scrollView addSubview:_calendarView];
    [_calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(103+_calendarView.heightCollection);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_remindView.mas_bottom).offset(0);
        
    }];
    
    
    _commentView = [[RoomDetailCommentView alloc] init];
    [_scrollView addSubview:_commentView];
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_calendarView.mas_bottom).offset(0);
        
    }];
    
    
    _locateInfoView = [[RoomDetailLocateInfoView alloc] init];
    [_scrollView addSubview:_locateInfoView];
    [_locateInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_commentView.mas_bottom).offset(0);
        
    }];
    
    
    _serviceView = [[RoomDetailServiceView alloc] init];
    [_scrollView addSubview:_serviceView];
    [_serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(260);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_locateInfoView.mas_bottom).offset(0);
        
    }];
    
    
    _noticeView = [[RoomDetailNoticeView alloc] init];
    [_scrollView addSubview:_noticeView];
    [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_serviceView.mas_bottom).offset(0);
        
    }];
    
    
    _characterView = [[RoomDetailCharacterView alloc] init];
    [_scrollView addSubview:_characterView];
    [_characterView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_noticeView.mas_bottom).offset(0);
        
    }];
    
    
    _nearbyRoomView = [[RoomDetailNearbyRoomView alloc] init];
    [_scrollView addSubview:_nearbyRoomView];
    [_nearbyRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(70+((MAIN_SCREEN_WIDTH-96)*2/3)+98);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_characterView.mas_bottom).offset(10);
        
    }];
    
    
    _btnBook = [[BlueButton alloc] init];
    _btnBook.title = @"立即预订";
    [self.view addSubview:_btnBook];
    [_btnBook mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(49);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        
    }];
    
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(_nearbyRoomView.mas_bottom).offset(49);
        
    }];
    
}

- (void)bindViewModel
{
    WS(ws);
    
    [RACObserve(self.viewModel, collection) subscribeNext:^(NSNumber *x) {
        
        ws.headView1.collectionView.states = x.integerValue;
        ws.headView2.collectionView.states = x.integerValue;
        
    }];
    
    RAC(_roomImagesView, dataArray2) = RACObserve(self.viewModel, roomImages);
    RAC(_priceView, price) = RACObserve(self.viewModel, price);
    RAC(_headView2, title) = RACObserve(self.viewModel, roomDesci);
    RAC(_titleTagsView, title) = RACObserve(self.viewModel, title);
    RAC(_titleTagsView, dataArray) = RACObserve(self.viewModel, characteristicTags);
    RAC(_baseInfoView, roomArea) = RACObserve(self.viewModel, roomArea);
    RAC(_baseInfoView, roomType) = RACObserve(self.viewModel, roomType);
    RAC(_baseInfoView, floor) = RACObserve(self.viewModel, floor);
    RAC(_baseInfoView, roomNo) = RACObserve(self.viewModel, roomNo);
    RAC(_baseInfoView, person) = RACObserve(self.viewModel, person);
    RAC(_baseInfoView, bedDesc) = RACObserve(self.viewModel, bedDesc);
    RAC(_remindView, remindArray) = RACObserve(self.viewModel, remind);
    RAC(_calendarView, today) = RACObserve(self.viewModel, today);
    RAC(_calendarView, roomStatus) = RACObserve(self.viewModel, roomStatus);
    RAC(_commentView, score) = RACObserve(self.viewModel, score);
    RAC(_commentView, commentNo) = RACObserve(self.viewModel, commentNo);
    RAC(_commentView, commentContent) = RACObserve(self.viewModel, commentContent);
    RAC(_locateInfoView, longitude) = RACObserve(self.viewModel, longitude);
    RAC(_locateInfoView, latitude) = RACObserve(self.viewModel, latitude);
    RAC(_locateInfoView, address) = RACObserve(self.viewModel, addressDetail);
    RAC(_serviceView, dataArray) = RACObserve(self.viewModel, serviceData);
    RAC(_noticeView, noticeArray) = RACObserve(self.viewModel, checkinNotice);
    RAC(_characterView, characterArray) = RACObserve(self.viewModel, roomCharacter);
    RAC(_nearbyRoomView, dataArray) = RACObserve(self.viewModel, nearbyRoom);
}

- (void)handleEvent
{
    WS(ws);
    @weakify(self);
    
    [[_headView1.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
    [[_headView1.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"分享");
        
        [ws share];
        
    }];
    [_headView1.collectionView addCollectionViewTouchBlock:^(CollectionView *view, BOOL flag) {
        
        NSNumber *input;
        if(flag)
            input = @1;
        else
            input = @2;
        
        if([DBManager getInstance].isLogin)
        {
            [[ws.viewModel.commandCollection execute:input] subscribeNext:^(NSString *x) {
                
                if(x && x.length)//失败
                {
                    [view changeStatesWithAnimate:NO];
                }
                
            }];
        }
        else
        {
            @strongify(self);
            PresentVC(LoginViewController);
        }
        
        
    }];
    
    [[_headView2.btnLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [ws back];
        
    }];
    [[_headView2.btnRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"分享");
        
        [ws share];
        
    }];
    [_headView2.collectionView addCollectionViewTouchBlock:^(CollectionView *view, BOOL flag) {
        
        NSNumber *input;
        if(flag)
            input = @1;
        else
            input = @2;
        
        if([DBManager getInstance].isLogin)
        {
            [[ws.viewModel.commandCollection execute:input] subscribeNext:^(NSString *x) {
                
                if(x && x.length)//失败
                {
                    [view changeStatesWithAnimate:NO];
                }
                
            }];
        }
        else
        {
            @strongify(self);
            PresentVC(LoginViewController);
        }
        
    }];
    
    
    
    
    [RACObserve(_scrollView, contentOffset) subscribeNext:^(id x) {
        
        CGFloat contentOffsetY = ws.scrollView.contentOffset.y;
        
        if(contentOffsetY<0)
        {
            [ws.roomImagesView stopTimer];
            
            ws.roomImagesView.origin = CGPointMake(0, contentOffsetY);
            ws.roomImagesView.height = RoomImagesViewHeight-contentOffsetY;
            ws.roomImagesView.scrollView.height = RoomImagesViewHeight-contentOffsetY;
            ws.roomImagesView.currentImageView.height = RoomImagesViewHeight-contentOffsetY;
        }
        else if(contentOffsetY==0)
        {
            [ws.roomImagesView startTimer];
            
            ws.headView1.hidden = NO;
            ws.headView2.hidden = YES;
            ws.headView1.alpha = 1;
            ws.headView2.alpha = 0;
        }
        else if(contentOffsetY<RoomImagesViewHeight)
        {
            ws.headView1.hidden = NO;
            ws.headView2.hidden = NO;
            
            ws.headView1.alpha = (RoomImagesViewHeight-contentOffsetY)/RoomImagesViewHeight;
            ws.headView2.alpha = contentOffsetY/RoomImagesViewHeight;
        }
        else
        {
            ws.headView1.hidden = YES;
            ws.headView2.hidden = NO;
            ws.headView1.alpha = 0;
            ws.headView2.alpha = 1;
        }
        
    }];
    
    
    [[self.viewModel.commandGetRoomDetailData execute:nil] subscribeNext:^(NSString *x) {
        
        if(x && x.length)
        {
            [[UIApplication sharedApplication].keyWindow makeToast:x];
        }
        
    }];
    
    
    
    [_roomImagesView addBannerViewTouchImageBlock:^(BannerModel *model, NSInteger index) {
        
        //NSLog(@"roomImage-%ld", index);
        
        NSMutableArray <BKPhotoItem *>*items = [NSMutableArray array];
        for(NSInteger i=0;i<ws.viewModel.roomImages.count;i++)
        {
            NSString *logo = @"http://qiniu.xbed.com.cn/PRODUCT/699/1481279598739_58.png";
            NSString *logoEncode = [logo base64String];
            
            NSString *url = [[NSString stringWithFormat:@"%@|watermark/1/image/%@/dissolve/90/gravity/Center/dy-16", ws.viewModel.roomImages[i], logoEncode] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"url=%@", url);
            
            BKPhotoItem *item = [[BKPhotoItem alloc] init];
            item.originImageUrl = [NSURL URLWithString:url];
            item.thumbView = ws.roomImagesView.backImageView;
            [items addObject:item];
        }
        
        BKPhotoBrowser *photoBrowser = [[BKPhotoBrowser alloc] initWithPhotoItems:items];
        photoBrowser.shouldShowPageControl = YES;
        photoBrowser.pageType = bottomPageCtrType;
        [photoBrowser showFromImageView:ws.roomImagesView.currentImageView andCurrentIndex:index completion:nil];
        
    }];
    
    
    
    
    [[_commentView.btnAll rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"全部评论");
        
        RoomEvaluateListViewModel *viewModel = [[RoomEvaluateListViewModel alloc] init];
        viewModel.roomId = ws.viewModel.roomId;
        viewModel.evaluateNumber = ws.viewModel.commentNo;
        viewModel.roomScore = ws.viewModel.roomScore;
        viewModel.cleanScore = ws.viewModel.cleanScore;
        PushVCWithVM(RoomEvaluateListViewController, viewModel);
        
    }];
    
    [[_locateInfoView.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"点击地图");
        
        RoomAddressViewModel *viewModel = [[RoomAddressViewModel alloc] init];
        viewModel.longitude = ws.viewModel.longitude;
        viewModel.latitude = ws.viewModel.latitude;
        viewModel.address = ws.viewModel.addressDetail;
        viewModel.parkInfo = ws.viewModel.parkInfo;
        viewModel.imageNavigation = ws.viewModel.imageNavigation;
        PushVCWithVM(RoomAddressViewController, viewModel);
        
    }];
    
    [[_serviceView.btnAll rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"查看全部－设施服务");
        
        ShowAllInfoView2 *infoView = [[ShowAllInfoView2 alloc] init];
        infoView.dataArray = ws.viewModel.serviceData;
        [ws.view addSubview:infoView];
        
    }];
    
    
    [[_noticeView.btnAll rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"查看全部－入住须知");
        
        
        ShowAllInfoView *infoView = [[ShowAllInfoView alloc] initWithContentHeight:MAIN_SCREEN_HEIGHT-150];
        infoView.title = @"入住须知";
        infoView.contentArray = ws.viewModel.checkinNotice;
        [ws.view addSubview:infoView];
        
    }];
    
    [[_characterView.btnAll rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"查看全部－房间特色");
        
        ShowAllInfoView *infoView = [[ShowAllInfoView alloc] initWithContentHeight:MAIN_SCREEN_HEIGHT-150];
        infoView.title = @"房间特色";
        infoView.contentArray = ws.viewModel.roomCharacter;
        [ws.view addSubview:infoView];
        
    }];
    
    
    [_nearbyRoomView addRoomDetailNearbyRoomViewDidSelectItemBlock:^(RoomDetailNearbyRoomView *view, NearbyRoomModel *model, NSInteger index) {
        
        RoomDetailViewModel *viewModel = [[RoomDetailViewModel alloc] init];
        viewModel.roomId = model.roomId;
        PushVCWithVM(RoomDetailViewController, viewModel);
        
    }];
    
    
    
    [[_btnBook rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"立即预订");
        
        if([DBManager getInstance].isLogin==NO)
        {
            @strongify(self);
            PresentVC(LoginViewController);
        }
        else
        {
            CheckinInfoConfirmViewModel *viewModel = [[CheckinInfoConfirmViewModel alloc] init];
            viewModel.rentType = ws.viewModel.rentType;
            viewModel.type = 0;
            viewModel.roomId = ws.viewModel.roomId;
            if(ws.viewModel.roomImages.count)
            {
                viewModel.roomImage = ws.viewModel.roomImages[0];
            }
            viewModel.title = ws.viewModel.title;
            viewModel.roomType = ws.viewModel.roomType;
            viewModel.person = ws.viewModel.person;
            PushVCWithVM(CheckinInfoConfirmViewController, viewModel);
        }
        
    }];
    
    
}





- (void)share
{
    NSString *title;
    if(self.viewModel.rentType==0)
    {
        title = [NSString stringWithFormat:@"[%@/晚] %@", [NSNumber numberWithFloat:self.viewModel.price.integerValue*0.01], self.viewModel.title];
    }
    else if(self.viewModel.rentType==1)
    {
        title = [NSString stringWithFormat:@"[%@/月] %@", [NSNumber numberWithFloat:self.viewModel.price.integerValue*0.01], self.viewModel.title];
    }
    
    NSString *desc;
    if(self.viewModel.roomType.length)
    {
        desc = [NSString stringWithFormat:@"%@ %@平米 宜住%@人", self.viewModel.roomType, self.viewModel.roomArea, self.viewModel.person];
    }
    else
    {
        desc = [NSString stringWithFormat:@"%@平米 宜住%@人", self.viewModel.roomArea, self.viewModel.person];
    }
    
    
    ShareView *shareView = [[ShareView alloc] init];
    shareView.title = title;
    shareView.descr = desc;
    shareView.image = self.roomImagesView.coverImage;
    shareView.url = [NSString stringWithFormat:@"%@/share/room/%@&rentType=%ld", URL_Web, self.viewModel.roomId, self.viewModel.rentType+1];
    [self.view addSubview:shareView];
}




- (RoomDetailViewModel *)viewModel
{
    if(_viewModel==nil)
    {
        _viewModel = [[RoomDetailViewModel alloc] init];
    }
    
    return _viewModel;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.viewModel = nil;
}



@end
