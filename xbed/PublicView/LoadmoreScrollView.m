//
//  LoadmoreScrollView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "LoadmoreScrollView.h"

@implementation LoadmoreScrollView

- (instancetype)init
{
    if(self = [super init])
    {
        WS(ws);
        _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            if(ws.block)
            {
                ws.block(ws.footer);
            }
            
        }];
        
        [_footer setTitle:@"加载更多..." forState:MJRefreshStateRefreshing];
        [_footer setTitle:@"" forState:MJRefreshStateIdle];
        
        self.mj_footer = _footer;
    }
    
    return self;
}

- (void)addLoadmoreScrollViewBlock:(LoadmoreScrollViewBlock)block
{
    _block = block;
}

@end
