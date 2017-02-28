//
//  StringCheckUtil.h
//  xbed
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringCheckUtil : NSObject

+ (BOOL)validatePhone:(NSString *)phone;
+ (BOOL)validateVcode:(NSString *)vcode;//验证码
+ (BOOL)validateIdentityCard:(NSString *)identityCard;
+ (BOOL)validateWord:(NSString *)word;

@end
