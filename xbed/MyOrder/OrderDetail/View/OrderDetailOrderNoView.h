//
//  OrderDetailOrderNoView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  订单号

#import <UIKit/UIKit.h>

@interface OrderDetailOrderNoView : UIView
{
@private
    UILabel *_lbOrderNo;
    UILabel *_lbDetail;
}

@property (nonatomic, strong)NSNumber *orderType;
@property (nonatomic, strong)NSString *orderNo;

@property (nonatomic, strong, readonly)UIButton *button;

@end
