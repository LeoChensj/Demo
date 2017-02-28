//
//  OrderDetailBelowLineVerifyView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/21.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  线下验证View

#import <UIKit/UIKit.h>

@interface OrderDetailBelowLineVerifyView : UIView

@property (nonatomic, strong)NSString *phone;

@property (nonatomic, strong, readonly)UILabel *lbRemind;
@property (nonatomic, strong, readonly)UIButton *button;
@property (nonatomic, assign, readonly)CGFloat myHeight;

@end
