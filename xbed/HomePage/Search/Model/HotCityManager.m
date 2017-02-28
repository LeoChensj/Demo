//
//  HotCityManager.m
//  xbed
//
//  Created by Leo.Chen on 16/10/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HotCityManager.h"

@implementation HotCityManager

@synthesize citys = _citys;

+ (instancetype)getInstance
{
    static HotCityManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[HotCityManager alloc] init];
        
    });
    
    return instance;
}

- (NSArray<NSString *> *)citys
{
    if(!_citys)
    {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"citys.txt"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:filePath])
        {
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            _citys = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        
        if(!_citys)
        {
            _citys = [NSMutableArray array];
        }
    }
    
    return _citys;
}

- (void)setCitys:(NSArray<NSString *> *)citys
{
    _citys = citys;
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"citys.txt"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:filePath])
    {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:citys];
    [data writeToFile:filePath atomically:YES];
}




@end
