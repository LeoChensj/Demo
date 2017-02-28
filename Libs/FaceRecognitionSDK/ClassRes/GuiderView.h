//
//  GuiderView.h
//  idface_kexin
//
//  Created by macbook on 15/9/10.
//  Copyright (c) 2015年 idface. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MyWindowClick1){
       MyWindowClickForOK1 = 0,
     MyWindowClickForCancel1
};



typedef void (^callBack1)(MyWindowClick1 buttonIndex);
@interface GuiderView : UIWindow


@property (nonatomic, copy) callBack1 clickBlock1 ;//按钮点击事件的回调
+ (instancetype) title1:(NSString *)title callBlock1:(callBack1)callBack1;

@end
