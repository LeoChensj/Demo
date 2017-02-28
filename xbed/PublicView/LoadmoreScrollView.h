//
//  LoadmoreScrollView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@class LoadmoreScrollView;

typedef void (^LoadmoreScrollViewBlock)(MJRefreshAutoStateFooter *footer);

@interface LoadmoreScrollView : UIScrollView

@property (nonatomic, strong, readonly)MJRefreshAutoStateFooter *footer;
@property (nonatomic, strong)LoadmoreScrollViewBlock block;

- (void)addLoadmoreScrollViewBlock:(LoadmoreScrollViewBlock)block;

@end
