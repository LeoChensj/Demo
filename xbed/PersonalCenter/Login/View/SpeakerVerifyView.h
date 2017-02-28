//
//  SpeakerVerifyView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  语音验证View

#import <UIKit/UIKit.h>

@interface SpeakerVerifyView : UIView


@property (nonatomic, strong, readonly)UILabel *lbInfo;
@property (nonatomic, strong, readonly)UIButton *btnVerify;

@property (nonatomic, assign)BOOL states;//no：正常   yes:倒计时

@end
