//
//  OrderPriceDetailCell.h
//  xbed
//
//  Created by Leo.Chen on 16/9/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface OrderPriceDetailCell : UIView
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
