//
//  OrderDetailScrollView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/16.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderDetailScrollView.h"

@implementation OrderDetailScrollView

- (instancetype)init
{
    if(self = [super init])
    {
        WS(ws);
        _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            if(ws.refreshBlock)
            {
                ws.refreshBlock(ws.header);
            }
            
        }];
        _header.stateLabel.textColor = Secondary_Text_Color2;
        _header.lastUpdatedTimeLabel.textColor = Secondary_Text_Color2;
        self.mj_header = _header;
    }
    
    return self;
}

- (void)addOrderDetailScrollViewRefreshBlock:(OrderDetailScrollViewRefreshBlock)refreshBlock
{
    self.refreshBlock = refreshBlock;
}

@end
