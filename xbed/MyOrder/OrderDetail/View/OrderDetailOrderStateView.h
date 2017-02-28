//
//  OrderDetailOrderStateView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  订单状态

#import <UIKit/UIKit.h>

@interface OrderDetailOrderStateView : UIView
{
@private
    UILabel *_lbState;
    UIImageView *_imgv1;
    UIImageView *_imgv2;
    UIImageView *_imgv3;
    UIView *_line1;
    UIView *_line2;
    UILabel *_lbValue1;
    UILabel *_lbValue2;
    UILabel *_lbValue3;
}

@property (nonatomic, strong)NSNumber *orderType;

@property (nonatomic, assign, readonly)CGFloat myHeight;

@end
