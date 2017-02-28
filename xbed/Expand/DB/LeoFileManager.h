//
//  LeoFileManager.h
//  xbed
//
//  Created by Leo.Chen on 2017/1/4.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeoFileManager : NSObject

+ (instancetype)getInstance;

/*
 Document文件夹：       程序退出不会删除此目录下的文件，iTunes会自动备份该目录，意味着版本升级覆盖安装会保留该文件夹下的数据
 方法：                [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
 
 Library文件夹：        同Document
 方法：                [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]
 
 Library/Caches：      程序退出不会删除此目录下的文件，但iTunes不会同步该目录，意味着版本升级覆盖安装不会保留该文件夹下的数据
 方法：                [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
 
 Library/Preferences： 用来存储用户的偏好设置，程序退出不会删除此目录下的文件，iTunes会自动备份该目录，通常这个文件夹都是由系统进行维护
                       的，建议不要操作他。
 方法：                 不要直接写偏好设置到这个文件夹，而是通过NSUserDefaults来进行偏好设置的保存和读取。
 
 tmp：                 保存应用程序的临时文件夹，程序退出后会删除此目录下的文件，iTunes也不会同步该目录
 方法：                 NSTemporaryDirectory()
 */

+ (BOOL)saveData:(id)data toFilePath:(NSString *)filePath;

+ (id)dataWithFilePath:(NSString *)filePath;

+ (BOOL)clearWithFilePath:(NSString *)filePath;


@end
