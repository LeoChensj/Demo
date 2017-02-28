//
//  RoomDetailViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/3.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailViewModel.h"
#import "RoomDetailRequest.h"
#import "CollectRoomRequest.h"

@implementation RoomDetailViewModel

- (void)setupSignal
{
    WS(ws);
    [[RACSignal combineLatest:@[RACObserve(self, roomScore), RACObserve(self, cleanScore)] reduce:^id(NSNumber *roomScore, NSNumber *cleanScore){
        
        return @(roomScore && cleanScore);
        
    }] subscribeNext:^(NSNumber *x) {
        
        if(x.boolValue)
        {
            ws.score = [NSNumber numberWithFloat:(ws.roomScore.floatValue+ws.cleanScore.floatValue)*0.5];
        }
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetRoomDetailData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            
            RoomDetailRequestModel *model = [[RoomDetailRequestModel alloc] init];
            model.roomId = ws.roomId;
            
            RoomDetailRequest *request = [[RoomDetailRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                [LoadingView close];
                
                RoomDetailRespModel *respModel = [request responseModel];
                
                if(respModel.data.pictures.count)
                {
                    NSMutableArray <NSString *>*mArrray = [NSMutableArray array];
                    for (NSInteger i=0;i<respModel.data.pictures.count;i++)
                    {
                        NSString *filePath = respModel.data.pictures[i].filePath;
                        NSNumber *cover = respModel.data.pictures[i].cover;
                        
                        if(cover.integerValue==1)
                        {
                            [mArrray insertObject:filePath atIndex:0];
                        }
                        else
                        {
                            [mArrray addObject:filePath];
                        }
                    }
                    ws.roomImages = mArrray;
                }
                
                if(ws.rentType==0)
                {
                    ws.price = respModel.data.curPrice;
                }
                else if(ws.rentType==1)
                {
                    ws.price = respModel.data.totalPrice;
                }
                
                ws.collection = respModel.data.baseInfo.collected;
                ws.title = respModel.data.baseInfo.custRoomName;
                ws.roomDesci = respModel.data.baseInfo.custRoomName;//暂时先用这个
                ws.characteristicTags = respModel.data.tag;
                ws.roomArea = respModel.data.baseInfo.area;
                ws.roomType = respModel.data.baseInfo.houseType;
                ws.floor = respModel.data.baseInfo.roomFloor;
                ws.roomNo = respModel.data.baseInfo.custRoomNo;
                ws.person = respModel.data.baseInfo.liveCount;
                ws.bedDesc = respModel.data.baseInfo.bedDescribe;
                ws.remind = respModel.data.remind;
                
                if(respModel.data.roomStatus && respModel.data.roomStatus.count)
                {
                    ws.today = respModel.data.roomStatus[0].calendarDate;
                    ws.roomStatus = respModel.data.roomStatus;
                }
                
                ws.roomScore = respModel.data.comment.roomGrade;
                ws.cleanScore = respModel.data.comment.cleanGrade;
                ws.commentNo = respModel.data.comment.commentsCount;
                ws.commentContent = respModel.data.comment.content;
                ws.addressDetail = respModel.data.baseInfo.custRoomAddr;
                ws.longitude = respModel.data.baseInfo.longitude;
                ws.latitude = respModel.data.baseInfo.latitude;
                ws.parkInfo = respModel.data.addition.traffic;
                if(respModel.data.naviPic.count)
                {
                    ws.imageNavigation = respModel.data.naviPic[0].filePath;
                }
                
                ws.serviceData = respModel.data.provServ;
                ws.checkinNotice = respModel.data.addition.guide;
                ws.roomCharacter = respModel.data.addition.tag;
                
                if(ws.rentType==0)//短租才展示附近房源
                {
                    if(respModel.data.nearRooms.count)
                    {
                        NSMutableArray <NearbyRoomModel *>*nearbyRooms = [NSMutableArray array];
                        for (NSInteger i=0;i<respModel.data.nearRooms.count;i++)
                        {
                            NearbyRoomModel *nearModel = [[NearbyRoomModel alloc] init];
                            nearModel.roomId = respModel.data.nearRooms[i].roomId;
                            nearModel.image = respModel.data.nearRooms[i].coverPic;
                            nearModel.title = respModel.data.nearRooms[i].custRoomName;
                            nearModel.roomType = respModel.data.nearRooms[i].houseType;
                            nearModel.person = respModel.data.nearRooms[i].liveCount;
                            if(respModel.data.nearRooms[i].roomGrade && respModel.data.nearRooms[i].cleanGrade)
                            {
                                nearModel.score = [NSNumber numberWithFloat:(respModel.data.nearRooms[i].roomGrade.floatValue+respModel.data.nearRooms[i].cleanGrade.floatValue)*0.5];
                            }
                            nearModel.distance = respModel.data.nearRooms[i].distance;
                            nearModel.price = respModel.data.nearRooms[i].price;
                            
                            [nearbyRooms addObject:nearModel];
                        }
                        
                        ws.nearbyRoom = nearbyRooms;
                    }
                }
                
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                [LoadingView close];
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            

            return nil;
        }];
        
        return signal;
    }];
    
    
    
    _commandCollection = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            CollectRoomRequestModel *model = [[CollectRoomRequestModel alloc] init];
            model.roomId = ws.roomId;
            model.type = input;
            model.rentType = [NSNumber numberWithInteger:ws.rentType+1];
            
            CollectRoomRequest *request = [[CollectRoomRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CollectRoomRespModel *respModel = [request responseModel];
                
                if(respModel.data.integerValue==1)
                {
                    ws.collection = @1;
                }
                else if(respModel.data.integerValue==2)
                {
                    ws.collection = @0;
                }
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            
            return nil;
        }];
        
        return signal;
    }];
    
}


@end
