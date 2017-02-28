//
//  StringCheckUtil.m
//  xbed
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "StringCheckUtil.h"

@implementation StringCheckUtil


+ (BOOL)validatePhone:(NSString *)phone;
{
    NSString *emailRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:phone];
}

+ (BOOL)validateVcode:(NSString *)vcode
{
    NSString *emailRegex = @"^\\d{4}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:vcode];
}

+ (BOOL)validateIdentityCard:(NSString *)identityCard
{
    NSString *emailRegex = @"^\\d{14}[[0-9],0-9xX]";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:identityCard];
}

+ (BOOL)validateWord:(NSString *)word
{
    NSString *emailRegex = @"^[A-Za-z0-9]{6,20}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:word];
}

@end
