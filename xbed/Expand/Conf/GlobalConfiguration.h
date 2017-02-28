//
//  GlobalConfiguration.h
//  xclear
//
//  Created by Leo.Chen on 16/6/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ENV  3

#if ENV == 0//开发
    #define URL_HOST                @"http://120.25.106.243:6890"
    #define URL_Web                 @"http://rewrite-test.xbed.com.cn"
    #define Wechat_Appid            @"wx14c3f56d37948799"
    #define UMeng_AppKey            @"566e90bfe0f55acad1001981"

#elif ENV == 1//测试
    #define URL_HOST                @"http://p6test.xbed.com.cn"
    #define URL_Web                 @"http://rewrite-test.xbed.com.cn"
    #define Wechat_Appid            @"wx14c3f56d37948799"
    #define UMeng_AppKey            @"566e90bfe0f55acad1001981"

#elif ENV == 2//预发布
    #define URL_HOST                @"http://p6gre.xbed.com.cn"
    #define URL_Web                 @"http://grewrite.xbed.com.cn"
    #define Wechat_Appid            @"wx14c3f56d37948799"
    #define UMeng_AppKey            @"566e90bfe0f55acad1001981"

#elif ENV == 3//生产(AppStore)
    #define URL_HOST                @"http://p6.xbed.com.cn"
    #define URL_Web                 @"http://rewrite.xbed.com.cn"
    #define Wechat_Appid            @"wx3646f621f7749844"
    #define UMeng_AppKey            @"566e8b4d67e58e57770008a2"

#endif

