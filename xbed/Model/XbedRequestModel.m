//
//  XbedRequestModel.m
//  xclear
//
//  Created by Leo.Chen on 16/6/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XbedRequestModel.h"

@implementation XbedRequestModel

- (instancetype)init
{
    if(self = [super init])
    {
        
    }
    
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}

- (id)requestParam
{
    if(_requestDict==nil)
    {
        _requestDict = [MTLJSONAdapter JSONDictionaryFromModel:self error:nil];
        _requestDict = [self removeNullFromDictionary:_requestDict];
        //_requestDict = (NSDictionary *)[self removeNullFrom:_requestDict];
        [self handleDictionnary:_requestDict];
    }
    
    return _requestDict;
}

- (id)headerParam
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSString *systemName = @"Xbed";
    NSString *systemPlatform = @"iOS";
    NSString *systemVersion = [DBManager getInstance].version;
    NSString *token = [DBManager getInstance].token ? [DBManager getInstance].token : @"";
    
    [dict setObject:systemName forKey:@"Goods"];
    [dict setObject:systemPlatform forKey:@"Terrace"];
    [dict setObject:systemVersion forKey:@"Edition"];
    [dict setObject:token forKey:@"Right"];
    
    NSString *pencil = [self createMd5Sign:[self requestParam]];
    [dict setObject:pencil forKey:@"Pencil"];
    
    //NSLog(@"Pencil=%@", pencil);
    
    return (NSDictionary *)dict;
}



#pragma mark - Helper
- (void)handleDictionnary:(NSDictionary *)dict
{
    NSMutableDictionary *mDict = (NSMutableDictionary *)dict;
    
    for (NSString *key in mDict.allKeys)
    {
        id value = [mDict objectForKey:key];
        
        if([value isEqual:[NSNull null]])
        {
            [mDict removeObjectForKey:key];
        }
        else if([value isKindOfClass:[NSDictionary class]] ||
                [value isKindOfClass:[NSArray class]] ||
                [value isKindOfClass:[NSMutableArray class]])//重要
        {
            NSString *jsonStr = [value JSONString];
            jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            [mDict setValue:jsonStr forKey:key];
        }
    }
}
- (NSMutableDictionary *)removeNullFromDictionary:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *strKey in dic.allKeys)
    {
        NSValue *value = dic[strKey];
        // 删除NSDictionary中的NSNull，再保存进字典
        if ([value isKindOfClass:NSDictionary.class])
        {
            mdic[strKey] = [self removeNullFromDictionary:(NSDictionary *)value];
        }
        // 删除NSArray中的NSNull，再保存进字典
        else if ([value isKindOfClass:NSArray.class])
        {
            mdic[strKey] = [self removeNullFromArray:(NSArray *)value];
        }
        // 剩余的非NSNull类型的数据保存进字典
        else if (![value isKindOfClass:NSNull.class])
        {
            mdic[strKey] = dic[strKey];
        }
    }
    return mdic;
}
- (NSMutableArray *)removeNullFromArray:(NSArray *)arr
{
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++)
    {
        NSValue *value = arr[i];
        // 删除NSDictionary中的NSNull，再添加进数组
        if ([value isKindOfClass:NSDictionary.class])
        {
            [marr addObject:[self removeNullFromDictionary:(NSDictionary *)value]];
        }
        // 删除NSArray中的NSNull，再添加进数组
        else if ([value isKindOfClass:NSArray.class])
        {
            [marr addObject:[self removeNullFromArray:(NSArray *)value]];
        }
        // 剩余的非NSNull类型的数据添加进数组
        else if (![value isKindOfClass:NSNull.class])
        {
            [marr addObject:value];
        }
    }
    return marr;
}
- (NSObject *)removeNullFrom:(NSObject *)object
{
    NSObject *objResult = nil;
    NSMutableArray *marrSearch = nil;
    if ([object isKindOfClass:NSNull.class]) {
        return nil;
    }
    else if ([object isKindOfClass:NSArray.class]) {
        objResult = [NSMutableArray arrayWithArray:(NSArray *)object];
        marrSearch = [NSMutableArray arrayWithObject:objResult];
    }
    else if ([object isKindOfClass:NSDictionary.class]) {
        objResult = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)object];
        marrSearch = [NSMutableArray arrayWithObject:objResult];
    }
    else {
        return object;
    }
    while (marrSearch.count > 0) {
        NSObject *header = marrSearch[0];
        if ([header isKindOfClass:NSMutableDictionary.class]) {
            // 遍历这个字典
            NSMutableDictionary *mdicTemp = (NSMutableDictionary *)header;
            for (NSString *strKey in mdicTemp.allKeys) {
                NSObject *objTemp = mdicTemp[strKey];
                // 将NSDictionary替换为NSMutableDictionary
                if ([objTemp isKindOfClass:NSDictionary.class]) {
                    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)objTemp];
                    mdicTemp[strKey] = mdic;
                    [marrSearch addObject:mdic];
                }
                // 将NSArray替换为NSMutableArray
                else if ([objTemp isKindOfClass:NSArray.class]) {
                    NSMutableArray *marr = [NSMutableArray arrayWithArray:(NSArray *)objTemp];
                    mdicTemp[strKey] = marr;
                    [marrSearch addObject:marr];
                }
                // 删除NSNull
                else if ([objTemp isKindOfClass:NSNull.class]) {
                    mdicTemp[strKey] = nil;
                }
            }
        }
        else if ([header isKindOfClass:NSMutableArray.class]) {
            // 遍历这个数组
            NSMutableArray *marrTemp = (NSMutableArray *)header;
            for (NSInteger i = marrTemp.count-1; i >= 0; i--) {
                NSObject *objTemp = marrTemp[i];
                // 将NSDictionary替换为NSMutableDictionary
                if ([objTemp isKindOfClass:NSDictionary.class]) {
                    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)objTemp];
                    [marrTemp replaceObjectAtIndex:i withObject:mdic];
                    [marrSearch addObject:mdic];
                }
                // 将NSArray替换为NSMutableArray
                else if ([objTemp isKindOfClass:NSArray.class]) {
                    NSMutableArray *marr = [NSMutableArray arrayWithArray:(NSArray *)objTemp];
                    [marrTemp replaceObjectAtIndex:i withObject:marr];
                    [marrSearch addObject:marr];
                }
                // 删除NSNull
                else if ([objTemp isKindOfClass:NSNull.class]) {
                    [marrTemp removeObjectAtIndex:i];
                }
            }
        }
        else {
            // 到这里就出错了
        }
        [marrSearch removeObjectAtIndex:0];
    }
    return objResult;
}




- (NSString *)createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray)
    {
        id value = [dict objectForKey:categoryId];
        
        NSString* jsonStr;
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]])
        {
            jsonStr = [[dict objectForKey:categoryId] JSONString];
        }
        else if ([value isKindOfClass:[NSString class]])
        {
            jsonStr = value;
        }
        else if ([value isKindOfClass:[NSNumber class]])
        {
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
            jsonStr = [numberFormatter stringFromNumber:value];
        }
        
        [contentString appendFormat:@"%@", jsonStr];
    }
    
    //添加key字段
    NSString *systemName = @"Xbed";
    NSString *systemPlatform = @"iOS";
    NSString *systemVersion = [DBManager getInstance].version;
    NSString *token = [DBManager getInstance].token ? [DBManager getInstance].token : @"";
    NSString *secret_Key = [[NSString stringWithFormat:@"%@%@%@%@", systemName, systemPlatform, systemVersion, token] MD5Digest];
    [contentString appendFormat:@"%@", secret_Key];
    
    NSString *md5Sign = [contentString MD5Digest];
    //NSLog(@"contentString=%@", contentString);
    //NSLog(@"md5Sign=%@", md5Sign);
    
    return md5Sign;
}

@end
