//
//  CheckinInfoConfirmOrderMoneyView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  订单价格明细

#import <UIKit/UIKit.h>

@interface OrderMoneyCell : UIView
{
@private
    UILabel *_lbTitle;
    UILabel *_lbValue;
    UIView *_line;
}

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSAttributedString *attrTitle;
@property (nonatomic, strong)NSString *value;
@property (nonatomic, strong)UIColor *valueColor;
@property (nonatomic, assign)BOOL haveLine;

@end


@interface CheckinInfoConfirmOrderMoneyView : UIView
{
@private
    OrderMoneyCell *_cellDeposit;
    OrderMoneyCell *_cellTotal;
    OrderMoneyCell *_cellDiscount;
    OrderMoneyCell *_cellActual;
}

@property (nonatomic, assign)NSInteger rentType;//0:短租  1:长租

@property (nonatomic, strong)NSNumber *deposit;//押金
@property (nonatomic, strong)NSNumber *totalMoney;
@property (nonatomic, strong)NSNumber *discountMoney;
@property (nonatomic, strong)NSNumber *actualMoney;

@property (nonatomic, assign, readonly)CGFloat myHeight;

- (instancetype)initWithRentType:(NSInteger)rentType;

@end
