//
//  ScreenRoomViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenRoomViewModel.h"
#import "ScreenRoomRequest.h"
#import "CollectRoomRequest.h"

@implementation ScreenRoomViewModel

- (void)setupSignal
{
    _signalDate = [RACSignal combineLatest:@[RACObserve(self, checkinDate), RACObserve(self, checkoutDate)] reduce:^id(NSDate *checkinDate, NSDate *checkoutDate){
        
        return @(checkinDate && checkoutDate && [checkinDate isLessDate:checkoutDate]);
        
    }];
    
    _signalPosition = [RACSignal combineLatest:@[RACObserve(self, position1), RACObserve(self, position2)] reduce:^id(ScreenRoomTagModel *position1, ScreenRoomTagModel *position2){
        
        return @(position2 && 1);
        
    }];
    
    _signalCondition = [RACSignal combineLatest:@[RACObserve(self, minPrice), RACObserve(self, maxPrice), RACObserve(self, type), RACObserve(self, bed), RACObserve(self, characteristic)] reduce:^id(NSNumber *minPrice, NSNumber *maxPrice, NSArray <NSNumber *>*type, NSNumber *bed, NSArray <NSNumber *> *characteristic){
        
        return @(minPrice || maxPrice || type.count || bed || characteristic.count);
        
    }];
    
    _signalSort = RACObserve(self, sort);
    
    
    
    _signalScreen = [RACSignal combineLatest:@[_signalDate, _signalPosition, _signalCondition, _signalSort] reduce:^id(NSNumber *date, NSNumber *position, NSNumber *condition, NSNumber *sort){
        
        return @(date || position.boolValue || condition.boolValue || sort);
        
    }];
    
    WS(ws);
    [RACObserve(self, isLocate) subscribeNext:^(NSNumber *x) {
        
        //排序种类写死的
        ScreenRoomTagModel *sortModel1 = [[ScreenRoomTagModel alloc] init];
        sortModel1.code = nil;
        ScreenRoomTagModel *sortModel2 = [[ScreenRoomTagModel alloc] init];
        sortModel2.cname = @"价格从低到高";
        sortModel2.code = @"10";
        ScreenRoomTagModel *sortModel3 = [[ScreenRoomTagModel alloc] init];
        sortModel3.cname = @"价格从高到低";
        sortModel3.code = @"11";
        
        if(x.boolValue)
        {
            sortModel1.cname = @"距离优先";
        }
        else
        {
            sortModel1.cname = @"默认排序";
        }
        
        ws.sortTags = @[sortModel1, sortModel2, sortModel3];
        
    }];
    
}

- (void)setupCommand
{
    WS(ws);
    
    ws.size = @10;
    
    _commandGetAllTagAndRoomList = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.start = @1;
            
            [LoadingView show];
            ScreenRoomRequestModel *model = [[ScreenRoomRequestModel alloc] init];
            model.start = ws.start;
            model.size = ws.size;
            model.flag = [NSNumber numberWithBool:YES];
            model.city = ws.city;
            model.rentType = [NSNumber numberWithInteger:ws.rentType+1];
            
            if(ws.isLocate && ws.sort.code==nil)
            {
                model.coordinate = [NSString stringWithFormat:@"%@,%@", ws.longitude, ws.latitude];
            }
            
            if(ws.position2.code.length)
            {
                model.query.position = ws.position2.code;
            }
            
            ScreenRoomRequest *request = [[ScreenRoomRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                ScreenRoomRespModel *respModel = [request responseModel];
                
                ws.cities = respModel.data.cities;
                ws.today = respModel.data.currTime;
                if(respModel.data.position.area && respModel.data.position.businessCircle && respModel.data.position.building)
                {
                    ws.positionTags = @[respModel.data.position.area, respModel.data.position.businessCircle, respModel.data.position.building];
                }
                ws.typeTags = respModel.data.houseTypeTag;
                ws.bedTags = respModel.data.bedCountTag;
                ws.characteristicTags = respModel.data.roomFeatureTag;
                
                ws.roomListData = respModel.data.roomList;
                ws.totalElements = respModel.data.totalElements;

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
    
    
    
    _commandGetAllTag = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.start = @1;
            
            [LoadingView show];
            ScreenRoomRequestModel *model = [[ScreenRoomRequestModel alloc] init];
            model.start = ws.start;
            model.size = ws.size;
            model.flag = [NSNumber numberWithBool:YES];
            model.city = ws.city;
            model.rentType = [NSNumber numberWithInteger:ws.rentType+1];
            
            if(ws.isLocate && ws.sort.code==nil)
            {
                model.coordinate = [NSString stringWithFormat:@"%@,%@", ws.longitude, ws.latitude];
            }
            
            if(ws.position2.code.length)
            {
                model.query.position = ws.position2.code;
            }
            
            ScreenRoomRequest *request = [[ScreenRoomRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                ScreenRoomRespModel *respModel = [request responseModel];
                
                ws.cities = respModel.data.cities;
                ws.today = respModel.data.currTime;
                if(respModel.data.position.area && respModel.data.position.businessCircle && respModel.data.position.building)
                {
                    ws.positionTags = @[respModel.data.position.area, respModel.data.position.businessCircle, respModel.data.position.building];
                }
                ws.typeTags = respModel.data.houseTypeTag;
                ws.bedTags = respModel.data.bedCountTag;
                ws.characteristicTags = respModel.data.roomFeatureTag;
                
                //长租且没有其他筛选条件，不会再进行1次网络请求获取房间列表，所以这里加载房间列表
                /*
                if(input.length || (ws.rentType==1 && ws.position1==nil && ws.position2==nil && ws.characteristic.count==0))
                {
                    ws.roomListData = respModel.data.roomList;
                    ws.totalElements = respModel.data.totalElements;
                }
                */
                
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
    
    
    _commandGetRoomList = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.start = @1;
            
            ScreenRoomRequestModel *model = [[ScreenRoomRequestModel alloc] init];
            model.start = ws.start;
            model.size = ws.size;
            model.flag = [NSNumber numberWithBool:NO];
            model.city = ws.city;
            model.rentType = [NSNumber numberWithInteger:ws.rentType+1];
            
            if(ws.isLocate && ws.sort.code==nil)
            {
                model.coordinate = [NSString stringWithFormat:@"%@,%@", ws.longitude, ws.latitude];
            }
            
            if(ws.sort.code)
            {
                model.orderBy = [NSNumber numberWithInteger:ws.sort.code.integerValue];
            }
            
            if(ws.position2.code)
            {
                model.query.position = ws.position2.code;
            }
            
            if(ws.bed)
            {
                model.query.screening.bedCount = [NSNumber numberWithInteger:ws.bed.cname.integerValue];
            }
            
            if(ws.type && ws.type.count)
            {
                model.query.screening.houseType = ws.type;
            }
            
            if(ws.characteristic && ws.characteristic.count)
            {
                model.query.screening.indiviTag = ws.characteristic;
            }
            
            if(ws.minPrice)
            {
                model.query.screening.price.minPrice = [NSNumber numberWithInteger:ws.minPrice.integerValue];
            }
            if(ws.maxPrice)
            {
                model.query.screening.price.maxPrice = [NSNumber numberWithInteger:ws.maxPrice.integerValue];
            }
            
            
            if(ws.checkinDate && ws.checkoutDate)
            {
                model.query.time.start = [NSString stringWithFormat:@"%ld-%02ld-%02ld", ws.checkinDate.year, ws.checkinDate.month, ws.checkinDate.day];
                model.query.time.end = [NSString stringWithFormat:@"%ld-%02ld-%02ld", ws.checkoutDate.year, ws.checkoutDate.month, ws.checkoutDate.day];
            }
            
            ScreenRoomRequest *request = [[ScreenRoomRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                ScreenRoomRespModel *respModel = [request responseModel];
                
                ws.roomListData = respModel.data.roomList;
                ws.totalElements = respModel.data.totalElements;
                
                
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
    
    
    _commandGetMoreRoomList = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            ws.start = [NSNumber numberWithInteger:ws.start.integerValue+1];
            
            ScreenRoomRequestModel *model = [[ScreenRoomRequestModel alloc] init];
            model.start = ws.start;
            model.size = ws.size;
            model.flag = [NSNumber numberWithBool:NO];
            model.city = ws.city;
            model.rentType = [NSNumber numberWithInteger:ws.rentType+1];
            
            if(ws.isLocate && ws.sort.code==nil)
            {
                model.coordinate = [NSString stringWithFormat:@"%@,%@", ws.longitude, ws.latitude];
            }
            
            if(ws.sort.code)
            {
                model.orderBy = [NSNumber numberWithInteger:ws.sort.code.integerValue];
            }
            
            if(ws.position2.code)
            {
                model.query.position = ws.position2.code;
            }
            
            if(ws.bed)
            {
                model.query.screening.bedCount = [NSNumber numberWithInteger:ws.bed.cname.integerValue];
            }
            
            if(ws.type && ws.type.count)
            {
                model.query.screening.houseType = ws.type;
            }
            
            if(ws.characteristic && ws.characteristic.count)
            {
                model.query.screening.indiviTag = ws.characteristic;
            }
            
            if(ws.minPrice)
            {
                model.query.screening.price.minPrice = [NSNumber numberWithInteger:ws.minPrice.integerValue];
            }
            if(ws.maxPrice)
            {
                model.query.screening.price.maxPrice = [NSNumber numberWithInteger:ws.maxPrice.integerValue];
            }
            
            if(ws.checkinDate && ws.checkoutDate)
            {
                model.query.time.start = [NSString stringWithFormat:@"%ld-%02ld-%02ld", ws.checkinDate.year, ws.checkinDate.month, ws.checkinDate.day];
                model.query.time.end = [NSString stringWithFormat:@"%ld-%02ld-%02ld", ws.checkoutDate.year, ws.checkoutDate.month, ws.checkoutDate.day];
            }
            
            ScreenRoomRequest *request = [[ScreenRoomRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                ScreenRoomRespModel *respModel = [request responseModel];
                
                ws.roomListData = [ws.roomListData arrayByAddingObjectsFromArray:respModel.data.roomList];
                ws.totalElements = respModel.data.totalElements;
                
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                
            } failure:^(__kindof LeoBaseRequest *request) {
                
                ws.start = [NSNumber numberWithInteger:ws.start.integerValue-1];
                
                [subscriber sendNext:[request getErrorMsg]];
                [subscriber sendCompleted];
                
            }];
            
            
            return nil;
        }];
        
        return signal;
    }];
    
    
    
    _commandCollection = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(CollectRoomRequestModel *input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            CollectRoomRequestModel *model = input;
            
            CollectRoomRequest *request = [[CollectRoomRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                CollectRoomRespModel *respModel = [request responseModel];
                
                for (NSInteger i=0;i<ws.roomListData.count;i++)
                {
                    if([ws.roomListData[i].roomId isEqualToNumber:model.roomId])
                    {
                        if(respModel.data.integerValue==1)
                        {
                            ws.roomListData[i].collected = [NSNumber numberWithBool:YES];
                        }
                        else if(respModel.data.integerValue==2)
                        {
                            ws.roomListData[i].collected = [NSNumber numberWithBool:NO];
                        }
                        break;
                    }
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



- (NSArray<ScreenRoomTagModel *> *)selectScreenModel
{
    NSMutableArray *mArr = [NSMutableArray array];
    
    if(self.checkinDate && self.checkoutDate)
    {
        ScreenRoomTagModel *model = [[ScreenRoomTagModel alloc] init];
        model.cname = [NSString stringWithFormat:@"%02ld/%02ld至%02ld/%02ld", self.checkinDate.month, self.checkinDate.day, self.checkoutDate.month, self.checkoutDate.day];
        model.type = @1;
        
        [mArr addObject:model];
    }
    
    if(self.position2)
    {
        ScreenRoomTagModel *model = [[ScreenRoomTagModel alloc] init];
        model.cname = [NSString stringWithFormat:@"%@", self.position2.cname];
        model.code = self.position2.code;
        model.type = @2;
        
        [mArr addObject:model];
    }
    
    if(self.minPrice || self.maxPrice)
    {
        NSString *min;
        NSString *max;
        
        if(self.minPrice)
        {
            min = [NSNumber numberWithInteger:self.minPrice.integerValue*0.01].stringValue;
        }
        else
        {
            min = @"0";
        }
        
        if(self.maxPrice)
        {
            max = [NSNumber numberWithInteger:self.maxPrice.integerValue*0.01].stringValue;
        }
        else
        {
            max = @"不限";
        }
        
        
        ScreenRoomTagModel *model = [[ScreenRoomTagModel alloc] init];
        model.cname = [NSString stringWithFormat:@"价格：%@－%@", min, max];
        model.type = @3;
        
        [mArr addObject:model];
    }
    
    if(self.type.count)
    {
        for (NSInteger i=0;i<self.type.count;i++)
            for (NSInteger j=0;j<self.typeTags.count;j++)
            {
                if([self.type[i] isEqualToString:self.typeTags[j].code])
                {
                    ScreenRoomTagModel *model = [[ScreenRoomTagModel alloc] init];
                    model.cname = self.typeTags[j].cname;
                    model.code = self.typeTags[j].code;
                    model.type = @4;
                    
                    [mArr addObject:model];
                    
                    break;
                }
            }
    }
    
    if(self.bed)
    {
        ScreenRoomTagModel *model = [[ScreenRoomTagModel alloc] init];
        model.cname = [NSString stringWithFormat:@"床数：%@", self.bed.cname];
        model.code = self.bed.code;
        model.type = @5;
        
        [mArr addObject:model];
    }
    
    if(self.characteristic.count)
    {
        for (NSInteger i=0;i<self.characteristic.count;i++)
            for (NSInteger j=0;j<self.characteristicTags.count;j++)
            {
                if([self.characteristic[i] isEqualToString:self.characteristicTags[j].code])
                {
                    ScreenRoomTagModel *model = [[ScreenRoomTagModel alloc] init];
                    model.cname = self.characteristicTags[j].cname;
                    model.code = self.characteristicTags[j].code;
                    model.type = @6;
                    
                    [mArr addObject:model];
                    
                    break;
                }
            }
    }
    
//    if(self.sort)
//    {
//        ScreenRoomTagModel *model = [[ScreenRoomTagModel alloc] init];
//        model.cname = self.sort.cname;
//        model.code = self.sort.code;
//        model.type = @7;
//        
//        [mArr addObject:model];
//    }
    
    return mArr;
}


@end
