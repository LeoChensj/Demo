//
//  OrderListBackScrollView.h
//  xbed
//
//  Created by Leo.Chen on 16/9/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  5个订单列表可以左右滑动

#import <UIKit/UIKit.h>

typedef void (^OrderListBackScrollViewBlock)(NSInteger index);

@interface OrderListBackScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong)OrderListBackScrollViewBlock block;
@property (nonatomic, assign)NSInteger index;

- (void)addOrderListBackScrollViewBlock:(OrderListBackScrollViewBlock)block;

@end
