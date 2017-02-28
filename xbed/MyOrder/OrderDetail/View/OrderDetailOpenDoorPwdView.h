//
//  OrderDetailOpenDoorPwdView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  开门密码View

#import <UIKit/UIKit.h>
#import "LeoRadioButton.h"

@interface OrderDetailOpenDoorPwdView : UIView
{
@private
    LeoRadioButton *_btnShowPwd;
}

@property (nonatomic, strong, readonly)UILabel *lbPwd;

@property (nonatomic, strong)NSString *password;
@property (nonatomic, assign, readonly)CGFloat myHeight;

@end
