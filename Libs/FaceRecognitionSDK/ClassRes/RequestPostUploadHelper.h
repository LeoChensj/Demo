//
//  RequestPostUploadHelper.h
//  BJIFF
//
//  Created by mac on 15/1/5.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestPostUploadHelper : NSObject


/**
 *POST 提交 并可以上传图片目前只支持单张
 */
+ (NSString *)postRequestWithURL: (NSString *)url  // IN
                      postParems: (NSMutableDictionary *)postParems // IN 提交参数据集合
                     picFilePath: (NSString *)picFilePath  // IN 上传图片路径
                     picFileName: (NSString *)picFileName;  // IN 上传图片名称

+ (NSMutableURLRequest *)postRequestWithURL: (NSString *)url  // IN
                      postParems: (NSMutableDictionary *)postParems // IN
                     picFilePath: (NSString *)picFilePath  // IN
                     picFileName: (NSString *)picFileName
                         fileKey: (NSString *)fileKdy; //上传字段名
/**
 * 修发图片大小
 */
+ (UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize;
/**
 * 保存图片
 */
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
/**
 * 生成GUID
 */
+ (NSString *)generateUuidString;

@end
