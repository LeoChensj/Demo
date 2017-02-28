//
//  PictureVerifyCodeView.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/28.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  图片验证码

#import <UIKit/UIKit.h>

@interface PictureVerifyCodeView : UIView
{
@private
    UIView *_vContent;
    UIImageView *_imgvCode;
}

@property (nonatomic, assign)BOOL flag;

@property (nonatomic, strong, readonly)UIButton *btnChange;
@property (nonatomic, strong, readonly)UITextField *tfCode;
@property (nonatomic, strong, readonly)UIButton *btnConfirm;

@property (nonatomic, strong)NSString *base64;
@property (nonatomic, strong)NSString *code;


- (void)close;

@end
