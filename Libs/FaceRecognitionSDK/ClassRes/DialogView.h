//
//  GuiderView.h
//  idface_kexin
//
//  Created by macbook on 15/9/10.
//  Copyright (c) 2015年 idface. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MyWindowClick){
    MyWindowClickForOK = 0,
    MyWindowClickForCancel
};



typedef void (^callBack)(MyWindowClick buttonIndex);
@interface DialogView: UIWindow


@property (nonatomic, copy) callBack clickBlock ;//按钮点击事件的回调
+ (instancetype) title:(NSString *)title title2:(NSString *)title2  callBlock:(callBack)callBack;

@end
