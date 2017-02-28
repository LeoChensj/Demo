//
//  LoginPhoneView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPhoneView : UIView
{
@protected
    UILabel *_lbTitle;
    UIView *_line;
}

@property (nonatomic, strong, readonly)LeoTextField *textField;

@end
