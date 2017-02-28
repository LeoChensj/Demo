//
//  HomeMainRefresh.h
//  xbed
//
//  Created by Leo.Chen on 16/7/15.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CBStoreHouseRefreshControl.h"

@class HomeMainRefresh;

typedef void (^HomeMainRefreshDataBlock)(HomeMainRefresh *refresh);



@interface HomeMainRefresh : CBStoreHouseRefreshControl <UIScrollViewDelegate>

@property (nonatomic, strong)HomeMainRefreshDataBlock block;


- (instancetype)initWithScrollView:(UIScrollView *)scrollView;
- (void)addHomeMainRefreshDataBlock:(HomeMainRefreshDataBlock)block;

@end
