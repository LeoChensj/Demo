//
//  ShareView.m
//  xbed
//
//  Created by Leo.Chen on 16/10/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ShareView.h"
#import "LeoShareManager.h"
#import "PhotoAlbumUtil.h"

@implementation ShareViewCell

- (instancetype)init
{
    if(self = [super init])
    {
        _imgvIcon = [[UIImageView alloc] init];
        [self addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(55);
            make.top.left.mas_equalTo(0);
            
        }];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(12);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(12);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_imgvIcon.mas_bottom).offset(15);
            
        }];
    }
    
    return self;
}

- (void)setIcon:(UIImage *)icon
{
    _icon = icon;
    
    _imgvIcon.image = icon;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _lbTitle.text = title;
}

@end



@implementation ShareView

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        _vContent = [[UIView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HEIGHT, MAIN_SCREEN_WIDTH, 260)];
        _vContent.backgroundColor = [UIColor whiteColor];
        [self addSubview:_vContent];
        
        UIView *vClose = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT-260)];
        [self addSubview:vClose];
        UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [vClose addGestureRecognizer:tapClose];
        
        
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"分享到";
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.textColor = Main_Text_Color;
        lbTitle.font = Font(18);
        [_vContent addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(18);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(25);
            
        }];
        
        
        CGFloat interval = (MAIN_SCREEN_WIDTH-25*XSCALE*2-4*55)/3;
        
        ShareViewCell *cell1 = [[ShareViewCell alloc] init];
        cell1.icon = [UIImage imageNamed:@"ic_share_wetchat"];
        cell1.title = @"微信";
        [_vContent addSubview:cell1];
        [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(85);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(45);
            make.left.mas_equalTo(25*XSCALE);
            
        }];
        [cell1 addTarget:self action:@selector(shareToWechatSession:) forControlEvents:UIControlEventTouchUpInside];
        
        ShareViewCell *cell2 = [[ShareViewCell alloc] init];
        cell2.icon = [UIImage imageNamed:@"ic_share_friendship"];
        cell2.title = @"朋友圈";
        [_vContent addSubview:cell2];
        [cell2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(85);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(45);
            make.left.mas_equalTo(cell1.mas_right).offset(interval);
            
        }];
        [cell2 addTarget:self action:@selector(shareToWechatTimeline:) forControlEvents:UIControlEventTouchUpInside];
        
        ShareViewCell *cell3 = [[ShareViewCell alloc] init];
        cell3.icon = [UIImage imageNamed:@"ic_share_weibo"];
        cell3.title = @"微博";
        [_vContent addSubview:cell3];
        [cell3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(85);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(45);
            make.left.mas_equalTo(cell2.mas_right).offset(interval);
            
        }];
        [cell3 addTarget:self action:@selector(shareToSina:) forControlEvents:UIControlEventTouchUpInside];
        
        ShareViewCell *cell4 = [[ShareViewCell alloc] init];
        cell4.icon = [UIImage imageNamed:@"ic_share_qq"];
        cell4.title = @"QQ";
        [_vContent addSubview:cell4];
        [cell4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(55);
            make.height.mas_equalTo(85);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(45);
            make.left.mas_equalTo(cell3.mas_right).offset(interval);
            
        }];
        [cell4 addTarget:self action:@selector(shareToQQ:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        UIButton *btnCancle = [[UIButton alloc] init];
        btnCancle.backgroundColor = Background_Color;
        [btnCancle setTitle:@"取消" forState:UIControlStateNormal];
        [btnCancle setTitleColor:Main_Text_Color forState:UIControlStateNormal];
        btnCancle.titleLabel.font = Font(16);
        [_vContent addSubview:btnCancle];
        [btnCancle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(49);
            make.left.bottom.mas_equalTo(0);
            
        }];
        [btnCancle addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _vContent.origin = CGPointMake(0, MAIN_SCREEN_HEIGHT-260);
            
        }];
    }
    
    return self;
}



- (void)shareToWechatSession:(UIButton *)button
{
    NSLog(@"微信好友");
    
    [self close];
    
    
    if([LeoShareManager isWechatAppInstalled])
    {
        if(!_image)
        {
            _image = [UIImage imageNamed:@"ic_xbed"];//默认分享图片
        }
        else
        {
            _image = [PhotoAlbumUtil imageWithImage:_image scaledToSize:CGSizeMake(150, 100)];
        }
        
        UMShareWebpageObject *shareObject = [[UMShareWebpageObject alloc] init];
        shareObject.title = _title;
        shareObject.descr = _descr;
        shareObject.thumbImage = _image;
        shareObject.webpageUrl = _url;
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.shareObject = shareObject;
        
        LeoShareManager *manager = [[LeoShareManager alloc] init];
        manager.messageObject = messageObject;
        manager.viewController = _viewController;
        [manager shareToPlatform:UMSocialPlatformType_WechatSession];
    }
    else
    {
        [[UIApplication sharedApplication].keyWindow makeToast:@"你还没有安装微信，请完成安装后重试"];
    }
}

- (void)shareToWechatTimeline:(UIButton *)button
{
    NSLog(@"微信朋友圈");
    
    [self close];
    
    if([LeoShareManager isWechatAppInstalled])
    {
        if(!_image)
        {
            _image = [UIImage imageNamed:@"ic_xbed"];//默认分享图片
        }
        else
        {
            _image = [PhotoAlbumUtil imageWithImage:_image scaledToSize:CGSizeMake(150, 100)];
        }
        
        UMShareWebpageObject *shareObject = [[UMShareWebpageObject alloc] init];
        shareObject.title = _title;
        shareObject.descr = _descr;
        shareObject.thumbImage = _image;
        shareObject.webpageUrl = _url;
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.shareObject = shareObject;
        
        LeoShareManager *manager = [[LeoShareManager alloc] init];
        manager.messageObject = messageObject;
        manager.viewController = _viewController;
        [manager shareToPlatform:UMSocialPlatformType_WechatTimeLine];
    }
    else
    {
        [[UIApplication sharedApplication].keyWindow makeToast:@"你还没有安装微信，请完成安装后重试"];
    }
}

- (void)shareToSina:(UIButton *)button
{
    NSLog(@"新浪");
    
    [self close];
    
    if([LeoShareManager isSinaAppInstalled])
    {
        if(!_image)
        {
            _image = [UIImage imageNamed:@"ic_xbed"];//默认分享图片
        }
        else
        {
            _image = [PhotoAlbumUtil imageWithImage:_image scaledToSize:CGSizeMake(150, 100)];
        }
        
        UMShareWebpageObject *shareObject = [[UMShareWebpageObject alloc] init];
        shareObject.title = _title;
        shareObject.descr = _descr;
        shareObject.thumbImage = _image;
        shareObject.webpageUrl = _url;
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.shareObject = shareObject;
        
        LeoShareManager *manager = [[LeoShareManager alloc] init];
        manager.messageObject = messageObject;
        manager.viewController = _viewController;
        [manager shareToPlatform:UMSocialPlatformType_Sina];
    }
    else
    {
        [[UIApplication sharedApplication].keyWindow makeToast:@"你还没有安装新浪微博，请完成安装后重试"];
    }
}

- (void)shareToQQ:(UIButton *)button
{
    NSLog(@"QQ");
    
    [self close];
    
    if([LeoShareManager isQQAppInstalled])
    {
        if(!_image)
        {
            _image = [UIImage imageNamed:@"ic_xbed"];//默认分享图片
        }
        else
        {
            _image = [PhotoAlbumUtil imageWithImage:_image scaledToSize:CGSizeMake(150, 100)];
        }
        
        UMShareWebpageObject *shareObject = [[UMShareWebpageObject alloc] init];
        shareObject.title = _title;
        shareObject.descr = _descr;
        shareObject.thumbImage = _image;
        shareObject.webpageUrl = _url;
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.shareObject = shareObject;
        
        LeoShareManager *manager = [[LeoShareManager alloc] init];
        manager.messageObject = messageObject;
        manager.viewController = _viewController;
        [manager shareToPlatform:UMSocialPlatformType_QQ];
    }
    else
    {
        [[UIApplication sharedApplication].keyWindow makeToast:@"你还没有安装QQ，请完成安装后重试"];
    }
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
