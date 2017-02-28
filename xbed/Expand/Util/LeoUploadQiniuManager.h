//
//  LeoUploadQiniuManager.h
//  xbed
//
//  Created by Leo.Chen on 16/10/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QiniuSDK.h>

typedef void(^LeoUploadQiniuSuccess)(id paramet, NSString *key, NSString *imageUrl);
typedef void(^LeoUploadQiniuFailure)();

@interface LeoUploadQiniuManager : NSObject


+ (void)uploadData:(NSData *)data token:(NSString *)token isPrivate:(BOOL)isPrivate paramet:(id)paramet success:(LeoUploadQiniuSuccess)blockSuccess failure:(LeoUploadQiniuFailure)blockFailure;

@end
