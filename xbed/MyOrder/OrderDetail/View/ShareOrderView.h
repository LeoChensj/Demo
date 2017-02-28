//
//  ShareOrderView.h
//  xbed
//
//  Created by Leo.Chen on 16/10/12.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  共享订单弹窗

#import <UIKit/UIKit.h>

@interface ShareOrderView : UIView
{
@private
    UIView *_vClose;
    UIView *_vContent;
    UIButton *_btnCancel;
}

@property (nonatomic, strong)XbedViewController *viewController;
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic, strong)NSString *url;


@property (nonatomic, strong, readonly)UIButton *btnShare;

- (void)show;
- (void)close;

@end
