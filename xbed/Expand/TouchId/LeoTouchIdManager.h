//
//  LeoTouchIdManager.h
//  xbed
//
//  Created by Leo.Chen on 16/11/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

typedef void(^LeoTouchIdManagerSuccessBlock)(void);
typedef void(^LeoTouchIdManagerFailureBlock)(LAError code);

@interface LeoTouchIdManager : NSObject

+ (BOOL)canTouchId;
+ (void)startWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle success:(LeoTouchIdManagerSuccessBlock)successBlock failureBlock:(LeoTouchIdManagerFailureBlock)failureBlock;

@end
