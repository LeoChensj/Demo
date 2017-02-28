//
//  FaceRecognitionHeader.h
//  xbed
//
//  Created by Leo.Chen on 16/10/24.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#ifndef FaceRecognitionHeader_h
#define FaceRecognitionHeader_h

//----------------- 常用工具类 --------------
#import  "UIViewExt.h"
#import "UIView+ViewController.h"
#import "AMTumblrHud.h"
#import "MyButton.h"
#import "MKNetworkKit.h"
//单元格尺寸
#define KCellHeight 44
#define KLeftWidth 15

//移除视图尺寸
#define cleanView_W 150
#define cleanView_H 40

//textField的高度
#define KtextFieldHeight 30

//底部按钮
#define KbottomButtonWidth 251
#define KbottomButtonHeight 43

//动态全局
#define DTitleImageSize 20
#define DCountImageSize 18
#define DCellHeight 70

//-------------- 本地数据----------------


// 姓名和身份证号码



#define KPassword @"Kpassword"
#define KName @"Kname"
#define KUserId @"Kuserid"
#define KUserpic @"Kuserpic"
#define KOpenClose @"Kopenclose"
#define KDebug @"Kdebug"
//6Plus
#define KButtonWidthSixPlus 293
#define KButtonHeightSixPlus 50

#define KCellHeightSixPlus 57

//--------------- 字体 ------------------------
#define KFont @"Roboto"

//--------------- 屏幕尺寸 ---------------------
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

//--------------- 可视尺寸 ------------------------
#define kVisibScreenHeight [[UIScreen mainScreen] bounds].size.height - 64 - 49

//--------------------- 当前系统版本 ------------------
#define kVersion [[[UIDevice currentDevice] systemVersion] floatValue]

//---------- 判断iphone6 ------------------
#define KiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//---------- 判断iphone6+ ------------------
#define KiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#endif /* FaceRecognitionHeader_h */
