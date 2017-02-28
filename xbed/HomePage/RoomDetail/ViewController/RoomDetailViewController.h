//
//  RoomDetailViewController.h
//  xbed
//
//  Created by Leo.Chen on 16/8/3.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewController.h"
#import "RoomDetailViewModel.h"
#import "RoomImagesView.h"
#import "PriceView.h"
#import "RoomDetailHeadView1.h"
#import "RoomDetailHeadView2.h"
#import "RoomDetailTitleTagsView.h"
#import "RoomDetailBaseInfoView.h"
#import "RoomDetailRemindView.h"
#import "RoomDetailCalendarView.h"
#import "RoomDetailCommentView.h"
#import "RoomDetailLocateInfoView.h"
#import "RoomDetailServiceView.h"
#import "RoomDetailNoticeView.h"
#import "RoomDetailCharacterView.h"
#import "RoomDetailNearbyRoomView.h"
#import "BlueButton.h"



@interface RoomDetailViewController : XbedViewController

@property (nonatomic, strong, readonly)UIScrollView *scrollView;
@property (nonatomic, strong, readonly)RoomImagesView *roomImagesView;
@property (nonatomic, strong, readonly)PriceView *priceView;
@property (nonatomic, strong, readonly)RoomDetailHeadView1 *headView1;
@property (nonatomic, strong, readonly)RoomDetailHeadView2 *headView2;
@property (nonatomic, strong, readonly)RoomDetailTitleTagsView *titleTagsView;
@property (nonatomic, strong, readonly)RoomDetailBaseInfoView *baseInfoView;
@property (nonatomic, strong, readonly)RoomDetailRemindView *remindView;
@property (nonatomic, strong, readonly)RoomDetailCalendarView *calendarView;
@property (nonatomic, strong, readonly)RoomDetailCommentView *commentView;
@property (nonatomic, strong, readonly)RoomDetailLocateInfoView *locateInfoView;
@property (nonatomic, strong, readonly)RoomDetailServiceView *serviceView;
@property (nonatomic, strong, readonly)RoomDetailNoticeView *noticeView;
@property (nonatomic, strong, readonly)RoomDetailCharacterView *characterView;
@property (nonatomic, strong, readonly)RoomDetailNearbyRoomView *nearbyRoomView;

@property (nonatomic, strong, readonly)BlueButton *btnBook;

@property (nonatomic, strong)RoomDetailViewModel *viewModel;

@end
