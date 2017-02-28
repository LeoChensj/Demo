//
//  DBManager.m
//  xclear
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

@synthesize token = _token;
@synthesize xdollarRules = _xdollarRules;
@synthesize homePageData = _homePageData;
@synthesize appUITextData = _appUITextData;

+ (DBManager *)getInstance
{
    static DBManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[DBManager alloc] init];
        instance.isLogin = NO;
        
    });
    
    return instance;
}



- (NSString *)token
{
    if(_token==nil || _token.length<=0)
    {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"token.txt"];
        
        _token = [LeoFileManager dataWithFilePath:filePath];
    }
    
    return _token;
}
- (void)setToken:(NSString *)token
{
    _token = token;
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"token.txt"];
    
    [LeoFileManager saveData:token toFilePath:filePath];
}

- (NSArray<NSString *> *)xdollarRules
{
    if(_xdollarRules==nil || _xdollarRules.count<=0)
    {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [cachesPath stringByAppendingPathComponent:@"xdollarRules.txt"];
        
        _xdollarRules = [LeoFileManager dataWithFilePath:filePath];
    }
    
    return _xdollarRules;
}
- (void)setXdollarRules:(NSArray<NSString *> *)xdollarRules
{
    _xdollarRules = xdollarRules;
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"xdollarRules.txt"];
    
    [LeoFileManager saveData:xdollarRules toFilePath:filePath];
}

- (HomeMainDataModel *)homePageData
{
    if(_homePageData==nil)
    {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [cachesPath stringByAppendingPathComponent:@"homePageData.txt"];
        
        _homePageData = [LeoFileManager dataWithFilePath:filePath];
    }
    
    return _homePageData;
}
- (void)setHomePageData:(HomeMainDataModel *)homePageData
{
    _homePageData = homePageData;
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"homePageData.txt"];
    
    [LeoFileManager saveData:homePageData toFilePath:filePath];
}

- (UIDataDataModel *)appUITextData
{
    if(_appUITextData==nil)
    {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [cachesPath stringByAppendingPathComponent:@"appUITextData.txt"];
        
        _appUITextData = [LeoFileManager dataWithFilePath:filePath];
        
        //默认数据
        if(_appUITextData==nil)
        {
            UIDataDataModel *appUITextData = [[UIDataDataModel alloc] init];
            appUITextData.checkinConfirmRemind = @"入住当天14:00后订单不可取消";
            appUITextData.orderRetainTime = @"2小时";
            appUITextData.serviceTelephone = @"400-609-9222";
            appUITextData.passwordText = @"口令可以分享给别人，如果你的订单没有支付，输入口令的人可以帮你支付，如果订单已经支付，则输入口令的人可以办理入住。";
            
            self.appUITextData = appUITextData;
        }
    }
    
    return _appUITextData;
}
- (void)setAppUITextData:(UIDataDataModel *)appUITextData
{
    _appUITextData = appUITextData;
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [cachesPath stringByAppendingPathComponent:@"appUITextData.txt"];
    
    [LeoFileManager saveData:appUITextData toFilePath:filePath];
}


- (NSString *)uuid
{
    if(_uuid==nil || _uuid.length<=0)
    {
        _uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    
    return _uuid;
}

- (NSString *)version
{
    if(_version==nil || _version.length<=0)
    {
        NSString *key = (NSString *)kCFBundleVersionKey;
        _version = [NSBundle mainBundle].infoDictionary[key];
    }
    
    return _version;
}

+ (BOOL)isNewVersion
{
    NSString *key = (NSString *)kCFBundleVersionKey;
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if([version isEqualToString:saveVersion])//版本号一样，不是第一次使用这个版本
    {
        return NO;
    }
    else//版本号不一样，第一次使用此版本
    {
        //新版本写入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        
        
        //下个版本使用，用于清空documents目录下的数据，下下个版本不需要，持久化但是iTunes不同步的数据都放在caches目录下
        //NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        //[LeoFileManager clearWithFilePath:documentsPath];
        
        return YES;
    }
    
    return NO;
}












@end
