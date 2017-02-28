//
//  PersonalCenterBaseInfoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXWaveView.h"

@interface PersonalCenterBaseInfoView : UIView
{
@private
    UIImageView *_imgvSetting;
    UIImageView *_imgvHead;
    UILabel *_lbPhone;
    UILabel *_lbXdollar;
    UILabel *_lbActivity;
    WXWaveView *_waveView;
}

@property (nonatomic, strong, readonly)UIButton *btnSetting;
@property (nonatomic, strong, readonly)UIButton *btnHeadImage;
@property (nonatomic, strong, readonly)UIButton *btnLogin;
@property (nonatomic, strong, readonly)UIButton *btnXdollar;
@property (nonatomic, strong, readonly)UIButton *btnActivity;

@property (nonatomic, assign)BOOL isLogin;
@property (nonatomic, strong)LoginModel *loginModel;

@end
