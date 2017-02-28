//
//  PriceView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  房间价格   黑色的那个

#import <UIKit/UIKit.h>

@interface PriceView : UIView
{
@private
    UILabel *_lbRMB;
    UILabel *_lbPrice;
}

@property (nonatomic, assign)NSInteger rentType;
@property (nonatomic, strong)NSNumber *price;

@end
