//
//  OrderListStateSelectView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListStateSelectCell.h"

@interface OrderListStateSelectView : UIView

@property (nonatomic, strong, readonly)NSMutableArray <OrderListStateSelectCell *>*cells;
@property (nonatomic, strong)NSNumber *index;

@end
