//
//  NSString+Helper.m
//  xbed
//
//  Created by Leo.Chen on 16/7/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

- (NSString *)toPinyin
{
    if (self.length)
    {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
        
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO);
        
        NSString *pinyin = [ms capitalizedString];//首字母大写
        
        return pinyin;

    }
    
    return nil;
}

@end
