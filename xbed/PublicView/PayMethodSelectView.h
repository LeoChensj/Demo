//
//  PayMethodSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/17.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  支付方式选择

#import <UIKit/UIKit.h>
#import "TouchView.h"

@interface PayMethodSelectCell : TouchView
{
@private
    UIImageView *_imgvIcon;
    UILabel *_lbTitle;
    UIView *_line;
}

@property (nonatomic, strong)UIImage *imgIcon;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)BOOL haveLine;

@end


typedef void(^PayMethodSelectViewCloseBlock)(void);

@interface PayMethodSelectView : UIView
{
@private
    UIView *_vCancel;
    UIView *_vContent;
}

@property (nonatomic, strong)PayMethodSelectViewCloseBlock closeBlock;

//@property (nonatomic, strong, readonly)PayMethodSelectCell *cellApplePay;
@property (nonatomic, strong, readonly)PayMethodSelectCell *cellWechat;
//@property (nonatomic, strong, readonly)PayMethodSelectCell *cellAlipay;
@property (nonatomic, strong, readonly)PayMethodSelectCell *cellUnion;

- (void)show;
- (void)close;
- (void)addPayMethodSelectViewCloseBlock:(PayMethodSelectViewCloseBlock)closeBlock;

@end
