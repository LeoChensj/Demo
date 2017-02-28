//
//  DES.h
//  xbed
//
//  Created by liujialin125 on 14/12/19.
//  Copyright (c) 2014年 liujialin125. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface DES : NSObject

+ (NSString *)encrypt:(NSString *)sText key:(NSString *)key;
+ (NSString *)decryptWithText:(NSString *)sText key:(NSString *)key;


@end
