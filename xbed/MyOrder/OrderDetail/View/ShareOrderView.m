//
//  ShareOrderView.m
//  xbed
//
//  Created by Leo.Chen on 16/10/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ShareOrderView.h"
#import "LeoShareManager.h"

@implementation ShareOrderView

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        
        _vClose = [[UIView alloc] init];
        [self addSubview:_vClose];
        [_vClose mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-260);
            make.left.top.mas_equalTo(0);
            
        }];
        
        UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [_vClose addGestureRecognizer:tapClose];
        
        
        
        
        
        _vContent = [[UIView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, 260)];
        _vContent.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vContent];
        
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"添加入住人";
        lbTitle.textColor = Main_Text_Color;
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.font = Font(18);
        [_vContent addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(18);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(25);
            
        }];
        
        
        UILabel *lbRemind = [[UILabel alloc] init];
        lbRemind.text = @"提醒：共享的人可以看到该订单，并办理入住";
        lbRemind.textColor = Red_Color;
        lbRemind.textAlignment = NSTextAlignmentCenter;
        lbRemind.font = Font(14);
        [_vContent addSubview:lbRemind];
        [lbRemind mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20);
            make.height.mas_equalTo(14);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(30);
            
        }];
        
        
        UIImageView *imgvIcon = [[UIImageView alloc] init];
        imgvIcon.image = [UIImage imageNamed:@"pic_wetcat"];
        [_vContent addSubview:imgvIcon];
        [imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(60);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(lbRemind.mas_bottom).offset(25);
            
        }];
        
        
        UILabel *lbWx = [[UILabel alloc] init];
        lbWx.text = @"微信";
        lbWx.textColor = Main_Text_Color;
        lbWx.textAlignment = NSTextAlignmentCenter;
        lbWx.font = Font(12);
        [_vContent addSubview:lbWx];
        [lbWx mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(imgvIcon.mas_bottom).offset(10);
            
        }];
        
        _btnShare = [[UIButton alloc] init];
        [_vContent addSubview:_btnShare];
        [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(82);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(imgvIcon.mas_top).offset(0);
            
        }];
        
        WS(ws);
        [[_btnShare rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws close];
            
            if(ws.url)
            {
                UMShareWebpageObject *shareObject = [[UMShareWebpageObject alloc] init];
                shareObject.title = @"我在Xbed为你订了房，快去办理入住吧";
                shareObject.descr = ws.desc;
                
                if(ws.image)
                {
                    shareObject.thumbImage = ws.image;
                }
                else
                {
                    shareObject.thumbImage = [UIImage imageNamed:@"ic_xbed"];
                }
                
                shareObject.webpageUrl = ws.url;
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                messageObject.shareObject = shareObject;
                
                LeoShareManager *manager = [[LeoShareManager alloc] init];
                manager.messageObject = messageObject;
                //manager.viewController = ws.viewController;
                [manager shareToPlatform:UMSocialPlatformType_WechatSession];
            }
            
        }];
        
        
        
        _btnCancel = [[UIButton alloc] init];
        _btnCancel.backgroundColor = Background_Color;
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel setTitleColor:Secondary_Text_Color forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = Font(16);
        [_vContent addSubview:_btnCancel];
        [_btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.bottom.mas_equalTo(0);
            
        }];
        [[_btnCancel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws close];
            
        }];
        
    }
    
    return self;
}

- (void)show
{
    [_viewController.view addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _vContent.origin = CGPointMake(0, MAIN_SCREEN_HEIGHT-260);
        
    }];
}

- (void)close
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _vContent.origin = CGPointMake(0, MAIN_SCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}




@end
