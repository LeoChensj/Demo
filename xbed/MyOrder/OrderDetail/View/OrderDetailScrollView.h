//
//  OrderDetailScrollView.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

typedef void(^OrderDetailScrollViewRefreshBlock)(MJRefreshNormalHeader *header);

@interface OrderDetailScrollView : UIScrollView

@property (nonatomic, strong, readonly)MJRefreshNormalHeader *header;
@property (nonatomic, strong)OrderDetailScrollViewRefreshBlock refreshBlock;


- (void)addOrderDetailScrollViewRefreshBlock:(OrderDetailScrollViewRefreshBlock)refreshBlock;

@end
