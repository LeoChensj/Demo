//
//  LeoFileManager.m
//  xbed
//
//  Created by Leo.Chen on 2017/1/4.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "LeoFileManager.h"

@implementation LeoFileManager

+ (instancetype)getInstance
{
    static LeoFileManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[LeoFileManager alloc] init];
        
    });
    
    return instance;
}



+ (BOOL)saveData:(id)data toFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:filePath])
    {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:data];
    
    return [archivedData writeToFile:filePath atomically:YES];
}

+ (id)dataWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:filePath])
    {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    return nil;
}

+ (BOOL)clearWithFilePath:(NSString *)filePath
{
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:nil];
    
    NSString *filePath2 = nil;
    NSError *error = nil;
    
    for (NSString *subPath in subPathArr)
    {
        filePath2 = [filePath stringByAppendingPathComponent:subPath];
        
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        
        if (error)
            return NO;
    }
    
    return YES;
}



@end
