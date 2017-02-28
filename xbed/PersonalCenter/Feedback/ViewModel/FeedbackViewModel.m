//
//  FeedbackViewModel.m
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "FeedbackViewModel.h"
#import "FeedbackRequest.h"
#import "EmojiCodeManager.h"

@implementation FeedbackViewModel

- (void)setupSignal
{
    _signalOpinion = [RACSignal combineLatest:@[RACObserve(self, opinion)] reduce:^id(NSString *opinion){
        
        return @(opinion && opinion.length>0);
        
    }];
}

- (void)setupCommand
{
    WS(ws);
    
    _commandSubmit = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            if(ws.opinion.length<=500)
            {
                if(![EmojiCodeManager isContainsEmoji:ws.opinion])
                {
                    [LoadingView show];
                    FeedbackRequestModel *model = [[FeedbackRequestModel alloc] init];
                    model.content = ws.opinion;
                    
                    FeedbackRequest *request = [[FeedbackRequest alloc] initWithRequestModel:model];
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
                else
                {
                    [subscriber sendNext:@"暂不支持输入表情符号"];
                    [subscriber sendCompleted];
                }
            }
            else
            {
                [subscriber sendNext:@"意见反馈不能超过500字"];
                [subscriber sendCompleted];
            }
            
            
            
            return nil;
        }];
        
        return signal;
    }];
}

@end
