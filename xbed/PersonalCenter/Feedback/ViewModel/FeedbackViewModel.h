//
//  FeedbackViewModel.h
//  xbed
//
//  Created by Leo.Chen on 16/9/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedViewModel.h"

@interface FeedbackViewModel : XbedViewModel

@property (nonatomic, strong)NSString *opinion;//意见

@property (nonatomic, strong, readonly)RACSignal *signalOpinion;
@property (nonatomic, strong, readonly)RACCommand *commandSubmit;

@end
