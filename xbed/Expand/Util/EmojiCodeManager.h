//
//  EmojiCodeManager.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  表情编码

#import <Foundation/Foundation.h>

@interface EmojiCodeManager : NSObject

+ (BOOL)isContainsEmoji:(NSString *)str;
+ (NSString *)encode:(NSString *)str;
+ (NSString *)decode:(NSString *)str;

@end
