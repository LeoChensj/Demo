//
//  MyCouponActivityInputView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnableButton.h"

@interface MyCouponActivityInputView : UIView
{
@private
    UITextField *_tfCoupon;
}

@property (nonatomic, strong, readonly)EnableButton *btnExchange;

@property (nonatomic, strong)NSString *code;

@end
