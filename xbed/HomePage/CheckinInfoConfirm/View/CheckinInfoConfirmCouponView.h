//
//  CheckinInfoConfirmCouponView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  优惠活动 xdollar

#import <UIKit/UIKit.h>
#import "TouchView.h"
#import "CalculatePriceRespModel.h"

@interface CheckinInfoConfirmCouponView : UIView
{
@private
    TouchView *_tvCoupon;
    UILabel *_lbTitleCoupon;
    //UILabel *_lbCouponValue;
    UIImageView *_imgvArrow;
    
    UIView *_vXdollar;
    UILabel *_lbXdollar;
    UISwitch *_swtXdollar;
}

@property (nonatomic, strong, readonly)UILabel *lbCouponValue;
@property (nonatomic, strong, readonly)UIButton *button;

@property (nonatomic, assign)NSInteger rentType;
@property (nonatomic, strong)NSNumber *activityCouponFlag;//1表示选择活动，2表示选择优惠券
@property (nonatomic, strong)ActivityContentsModel *selectActivity;//选择的活动
@property (nonatomic, strong)CouponCardModel *selectCoupon;//选择的优惠券
@property (nonatomic, strong)NSNumber *xdollar;
@property (nonatomic, strong)NSNumber *xdollarOn;

- (instancetype)initWithRentType:(NSInteger)rentType;

@end
