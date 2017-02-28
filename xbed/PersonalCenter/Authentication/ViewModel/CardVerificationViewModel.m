//
//  CardVerificationViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/8/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CardVerificationViewModel.h"
#import "QueryCheckinPersonRequest.h"
#import "SubmitIdcardRequest.h"
#import "LeoUploadQiniuManager.h"

@implementation CardVerificationViewModel

- (void)setupSignal
{
    _signalSave = [RACSignal combineLatest:@[RACObserve(self, checkinPersonData.name), RACObserve(self, checkinPersonData.idNo), RACObserve(self, imageData1), RACObserve(self, checkinPersonData.holdImage)] reduce:^id(NSString *name, NSString *idNo, NSString *imageData1, NSString *holdImage){
        
        return @(name.length && idNo.length && (imageData1.length || holdImage.length));
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandGetCheckinInfo = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [LoadingView show];
            QueryCheckinPersonRequestModel *model = [[QueryCheckinPersonRequestModel alloc] init];
            model.isPrivate = @1;
            model.phone = [DBManager getInstance].loginModel.phone;
            
            QueryCheckinPersonRequest *request = [[QueryCheckinPersonRequest alloc] initWithRequestModel:model];
            [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                
                QueryCheckinPersonRespModel *respModel = [request responseModel];
                ws.checkinPersonData = respModel.data;
                
                
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
    
    
    _commandSave = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            if(ws.checkinPersonData.idNo.length==18)
            {
                if(ws.imageData1.length)//用户修改了照片
                {
                    [LoadingView show];
                    [LeoUploadQiniuManager uploadData:ws.imageData1 token:ws.checkinPersonData.QiNiu_token isPrivate:YES paramet:nil success:^(id paramet, NSString *key, NSString *imageUrl) {
                        
                        NSLog(@"%@=%@", key, imageUrl);
                        
                        SubmitIdcardRequestModel *model = [[SubmitIdcardRequestModel alloc] init];
                        model.idNo = ws.checkinPersonData.idNo;
                        model.holdImage = imageUrl;
                        model.infoId = ws.checkinPersonData.infoId;
                        model.name = ws.checkinPersonData.name;
                        model.type = @1;
                        
                        SubmitIdcardRequest *request = [[SubmitIdcardRequest alloc] initWithRequestModel:model];
                        [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                            
                            //UpdateCheckinPersonRespModel *respModel = [request responseModel];
                            
                            [LoadingView close];
                            [subscriber sendNext:nil];
                            [subscriber sendCompleted];
                            
                        } failure:^(__kindof LeoBaseRequest *request) {
                            
                            [LoadingView close];
                            [subscriber sendNext:[request getErrorMsg]];
                            [subscriber sendCompleted];
                            
                        }];
                        
                    } failure:^{
                        
                        [LoadingView close];
                        [subscriber sendNext:@"Upload Qiniu failure"];
                        [subscriber sendCompleted];
                        
                    }];
                }
                else//用户没有修改照片
                {
                    if(ws.checkinPersonData && ws.checkinPersonData.holdImage.length)//有图片
                    {
                        [LoadingView show];
                        SubmitIdcardRequestModel *model = [[SubmitIdcardRequestModel alloc] init];
                        model.idNo = ws.checkinPersonData.idNo;
                        model.infoId = ws.checkinPersonData.infoId;
                        model.name = ws.checkinPersonData.name;
                        model.type = @1;
                        
                        SubmitIdcardRequest *request = [[SubmitIdcardRequest alloc] initWithRequestModel:model];
                        [request startWithCompletionBlockWithSuccess:^(__kindof LeoBaseRequest *request) {
                            
                            
                            [LoadingView close];
                            [subscriber sendNext:nil];
                            [subscriber sendCompleted];
                            
                        } failure:^(__kindof LeoBaseRequest *request) {
                            
                            [LoadingView close];
                            [subscriber sendNext:[request getErrorMsg]];
                            [subscriber sendCompleted];
                            
                        }];
                    }
                    else//没有图片
                    {
                        [subscriber sendNext:@"请选择身份证图片"];
                        [subscriber sendCompleted];
                    }
                    
                }
            }
            else
            {
                [subscriber sendNext:@"请正确输入身份证号"];
                [subscriber sendCompleted];
            }
            
            return nil;
        }];
        
        return signal;
    }];
    
    
}

@end
