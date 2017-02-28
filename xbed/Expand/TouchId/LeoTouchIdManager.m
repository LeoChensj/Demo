//
//  LeoTouchIdManager.m
//  xbed
//
//  Created by Leo.Chen on 16/11/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LeoTouchIdManager.h"

@implementation LeoTouchIdManager

+ (BOOL)canTouchId
{
    if(More_iOS8)
    {
        LAContext* context = [[LAContext alloc] init];
        NSError* error = nil;
        
        //判断设备是否支持
        if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
        {
            return YES;
        }
        else
        {
            return NO;
        }
        
    }
    
    return NO;
}

+ (void)startWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle success:(LeoTouchIdManagerSuccessBlock)successBlock failureBlock:(LeoTouchIdManagerFailureBlock)failureBlock;
{
    if([LeoTouchIdManager canTouchId])
    {
        LAContext* context = [[LAContext alloc] init];
        context.localizedFallbackTitle = fallbackTitle;
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message reply:^(BOOL success, NSError * _Nullable error) {
            
            if(success)
            {
                if(successBlock)
                {
                    successBlock();
                }
            }
            else
            {
                if(failureBlock)
                {
                    failureBlock(error.code);
                }
            }
            
            
        }];
    }
    else
    {
        NSLog(@"不支持touchId");
    }
}



@end
