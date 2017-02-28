//
//  LeoUploadQiniuManager.m
//  xbed
//
//  Created by Leo.Chen on 16/10/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LeoUploadQiniuManager.h"

@implementation LeoUploadQiniuManager

+ (void)uploadData:(NSData *)data token:(NSString *)token isPrivate:(BOOL)isPrivate paramet:(id)paramet success:(LeoUploadQiniuSuccess)blockSuccess failure:(LeoUploadQiniuFailure)blockFailure
{
    NSString *imageKey = [NSString stringWithFormat:@"Xbed/iOS/Photo/%ld_%u.jpeg", (NSInteger)[[NSDate date] timeIntervalSince1970], arc4random()%1000];
    
    QNUploadOption *opt = nil;
    
    if(isPrivate)
    {
        opt = [[QNUploadOption alloc] initWithMime:@"text/plain" progressHandler:nil params:@{@"x:isPrivate":@"1", @"x:fileDirId":@"-1", @"x:remark":@"iOS身份证上传"} checkCrc:YES cancellationSignal:nil];
    }
    
    //https
    QNAutoZone * httpsZone = [[QNAutoZone alloc] initWithHttps:YES dns:nil];
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = httpsZone;
        //builder.disableATS = YES;
    }];
    
    QNUploadManager *manager = [[QNUploadManager alloc] initWithConfiguration:config];
    //QNUploadManager *manager = [[QNUploadManager alloc] init];
    [manager putData:data key:imageKey token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        
        if(resp)
        {
            NSString *imageUrl = resp[@"materialBase"][@"url"];
            //imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
            
            if(blockSuccess)
            {
                blockSuccess(paramet, key, imageUrl);
            }
            
        }
        else
        {
            if(blockFailure)
            {
                blockFailure();
            }
        }
        
        
        
    } option:opt];
}

@end
