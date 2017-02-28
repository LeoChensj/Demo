//
//  RoomEvaluateViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluateViewModel.h"
#import "GetRoomEvaluateRequest.h"
#import "RoomEvaluateRequest.h"
#import "QiniuTokenRequest.h"
#import "LeoUploadQiniuManager.h"
#import "EmojiCodeManager.h"

@implementation RoomEvaluateViewModel

- (void)setupCommand
{
    WS(ws);
    
    _commandGetData = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            GetRoomEvaluateRequestModel *model = [[GetRoomEvaluateRequestModel alloc] init];
            model.checkinId = ws.checkinId;
            model.roomId = ws.roomId;
            GetRoomEvaluateRequest *request = [[GetRoomEvaluateRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                GetRoomEvaluateRespModel *respModel = [request responseModel];
                ws.waitEvaluateData = respModel.data.waitEvaluate;
                ws.evaluatedData = respModel.data.evaluated;
                ws.overdueData = respModel.data.overdue;
                
                if(ws.waitEvaluateData)
                {
                    ws.roomEvaluateState = @1;
                }
                else if(ws.evaluatedData)
                {
                    if(ws.evaluatedData.nearRoomList.count)
                    {
                        NSMutableArray <NearbyRoomModel *>*nearbyRooms = [NSMutableArray array];
                        for (NSInteger i=0;i<ws.evaluatedData.nearRoomList.count;i++)
                        {
                            NearbyRoomModel *nearModel = [[NearbyRoomModel alloc] init];
                            nearModel.roomId = ws.evaluatedData.nearRoomList[i].roomId;
                            nearModel.image = ws.evaluatedData.nearRoomList[i].coverPic;
                            nearModel.title = ws.evaluatedData.nearRoomList[i].custRoomName;
                            nearModel.roomType = ws.evaluatedData.nearRoomList[i].houseType;
                            nearModel.person = ws.evaluatedData.nearRoomList[i].liveCount;
                            if(ws.evaluatedData.nearRoomList[i].roomGrade && ws.evaluatedData.nearRoomList[i].cleanGrade)
                            {
                                nearModel.score = [NSNumber numberWithFloat:(ws.evaluatedData.nearRoomList[i].roomGrade.floatValue+ws.evaluatedData.nearRoomList[i].cleanGrade.floatValue)*0.5];
                            }
                            nearModel.distance = ws.evaluatedData.nearRoomList[i].distance;
                            nearModel.price = ws.evaluatedData.nearRoomList[i].price;
                            
                            [nearbyRooms addObject:nearModel];
                        }
                        
                        ws.nearbyRoomData = nearbyRooms;
                    }
                    
                    ws.roomEvaluateState = @2;
                }
                else if(ws.overdueData)
                {
                    if(ws.overdueData.nearRoomList.count)
                    {
                        NSMutableArray <NearbyRoomModel *>*nearbyRooms = [NSMutableArray array];
                        for (NSInteger i=0;i<ws.overdueData.nearRoomList.count;i++)
                        {
                            NearbyRoomModel *nearModel = [[NearbyRoomModel alloc] init];
                            nearModel.roomId = ws.overdueData.nearRoomList[i].roomId;
                            nearModel.image = ws.overdueData.nearRoomList[i].coverPic;
                            nearModel.title = ws.overdueData.nearRoomList[i].custRoomName;
                            nearModel.roomType = ws.overdueData.nearRoomList[i].houseType;
                            nearModel.person = ws.overdueData.nearRoomList[i].liveCount;
                            if(ws.overdueData.nearRoomList[i].roomGrade && ws.overdueData.nearRoomList[i].cleanGrade)
                            {
                                nearModel.score = [NSNumber numberWithFloat:(ws.overdueData.nearRoomList[i].roomGrade.floatValue+ws.overdueData.nearRoomList[i].cleanGrade.floatValue)*0.5];
                            }
                            nearModel.distance = ws.overdueData.nearRoomList[i].distance;
                            nearModel.price = ws.overdueData.nearRoomList[i].price;
                            
                            [nearbyRooms addObject:nearModel];
                        }
                        
                        ws.nearbyRoomData = nearbyRooms;
                    }
                    
                    ws.roomEvaluateState = @3;
                }
                
                
                [LoadingView close];
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
    
    
    
    
    //提交评论
    _commandSubmit = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            if(ws.subRoomStarId)
            {
                if(ws.subCleanStarId)
                {
                    if(![EmojiCodeManager isContainsEmoji:ws.subContent])
                    {
                        if(ws.subPicDataList && ws.subPicDataList.count)//有图片
                        {
                            [LoadingView show];
                            
                            QiniuTokenRequestModel *tokenModel = [[QiniuTokenRequestModel alloc] init];
                            QiniuTokenRequest *tokenRequest = [[QiniuTokenRequest alloc] initWithRequestModel:tokenModel];
                            [tokenRequest startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                                
                                QiniuTokenRespModel *tokenRespModel = [request responseModel];
                                
                                ws.subPicPathList = @[];
                                for (NSInteger i=0;i<ws.subPicDataList.count;i++)
                                {
                                    [LeoUploadQiniuManager uploadData:ws.subPicDataList[i] token:tokenRespModel.data isPrivate:NO paramet:nil success:^(id paramet, NSString *key, NSString *imageUrl) {
                                        
                                        if(imageUrl.length>0)
                                        {
                                            ws.subPicPathList = [ws.subPicPathList arrayByAddingObject:imageUrl];
                                        }
                                        
                                    } failure:^{
                                        
                                        [LoadingView close];
                                        [subscriber sendNext:@"上传图片失败"];
                                        [subscriber sendCompleted];
                                        
                                    }];
                                }
                                
                                
                                [RACObserve(ws, subPicPathList) subscribeNext:^(NSArray <NSString *>*x) {
                                    
                                    if(x.count>=ws.subPicDataList.count)//图片全部上传Qiniu完成
                                    {
                                        NSLog(@"上传七牛完成");
                                        
                                        RoomEvaluateRequestModel *model = [[RoomEvaluateRequestModel alloc] init];
                                        model.flag = ws.flag;
                                        model.checkinId = ws.checkinId;
                                        model.roomStarId = ws.subRoomStarId;
                                        model.roomTermIdList = ws.subRoomTermIdList;
                                        model.cleanStarId = ws.subCleanStarId;
                                        model.cleanTermIdList = ws.subCleanTermIdList;
                                        if(ws.subContent && ws.subContent.length)
                                        {
                                            model.content = ws.subContent;
                                        }
                                        model.picPathList = ws.subPicPathList;
                                        RoomEvaluateRequest *request = [[RoomEvaluateRequest alloc] initWithRequestModel:model];
                                        [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                                            
                                            if(ws.flag)
                                            {
                                                RoomEvaluateRespModel *respModel = [request responseModel];
                                                ws.evaluatedData = respModel.data.evaluated;
                                            }
                                            
                                            [LoadingView close];
                                            [subscriber sendNext:nil];
                                            [subscriber sendCompleted];
                                            
                                        } failure:^(__kindof LeoBaseRequest *request) {
                                            
                                            [LoadingView close];
                                            [subscriber sendNext:@"评价失败"];
                                            [subscriber sendCompleted];
                                            
                                        }];
                                        
                                    }
                                    
                                }];
                                
                                
                                
                            } failure:^(__kindof LeoBaseRequest *request) {
                                
                                [LoadingView close];
                                [subscriber sendNext:[request getErrorMsg]];
                                [subscriber sendCompleted];
                                
                            }];
                            
                            
                        }
                        else//没图片
                        {
                            [LoadingView show];
                            
                            RoomEvaluateRequestModel *model = [[RoomEvaluateRequestModel alloc] init];
                            model.flag = ws.flag;
                            model.checkinId = ws.checkinId;
                            model.roomStarId = ws.subRoomStarId;
                            model.roomTermIdList = ws.subRoomTermIdList;
                            model.cleanStarId = ws.subCleanStarId;
                            model.cleanTermIdList = ws.subCleanTermIdList;
                            if(ws.subContent && ws.subContent.length)
                            {
                                model.content = ws.subContent;
                            }
                            RoomEvaluateRequest *request = [[RoomEvaluateRequest alloc] initWithRequestModel:model];
                            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                                
                                if(ws.flag)
                                {
                                    RoomEvaluateRespModel *respModel = [request responseModel];
                                    ws.evaluatedData = respModel.data.evaluated;
                                }
                                
                                [LoadingView close];
                                [subscriber sendNext:nil];
                                [subscriber sendCompleted];
                                
                            } failure:^(__kindof LeoBaseRequest *request) {
                                
                                [LoadingView close];
                                [subscriber sendNext:@"评价失败"];
                                [subscriber sendCompleted];
                                
                            }];
                            
                        }
                    }
                    else
                    {
                        [subscriber sendNext:@"暂不支持输入表情符号"];
                        [subscriber sendCompleted];
                    }
                }
                else
                {
                    [subscriber sendNext:@"先给清洁打分"];
                    [subscriber sendCompleted];
                }
            }
            else
            {
                [subscriber sendNext:@"先给房间打分"];
                [subscriber sendCompleted];
            }
            
            
            return nil;
        }];
        
        return signal;
    }];
    
}

@end
