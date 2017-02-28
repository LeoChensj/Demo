//
//  SearchHistoryRecordArray.m
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "SearchRecordManager.h"

@implementation SearchRecordModel

@end




@implementation SearchRecordManager

@synthesize records = _records;


+ (instancetype)getInstance
{
    static SearchRecordManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[SearchRecordManager alloc] init];
        
    });
    
    return instance;
}


- (NSMutableArray<SearchRecordModel *> *)records
{
    if(!_records)
    {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"searchRecords.txt"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:filePath])
        {
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            _records = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        
        if(!_records)
        {
            _records = [NSMutableArray array];
        }
    }
    
    return _records;
}
- (void)setRecords:(NSMutableArray<SearchRecordModel *> *)records
{
    _records = records;
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"searchRecords.txt"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:filePath])
    {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:records];
    [data writeToFile:filePath atomically:YES];
}

- (void)addRecord:(SearchRecordModel *)record
{
    BOOL flagHaveRecord = NO;
    NSInteger index = 0;
    for(NSInteger i=0;i<self.records.count;i++)
    {
        if([record.cname isEqualToString:self.records[i].cname])
        {
            flagHaveRecord = YES;
            index = i;
            break;
        }
    }
    
    if(flagHaveRecord)//有相同记录
    {
        [self.records removeObjectAtIndex:index];
        [self.records insertObject:record atIndex:0];
    }
    else//无相同记录
    {
        [self.records insertObject:record atIndex:0];
        
        while(self.records.count>5)
        {
            [self.records removeObjectAtIndex:5];
        }
    }
    
    self.records = _records;//持久化
}
- (void)clear
{
    self.records = nil;
}








@end
