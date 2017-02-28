//
//  XdollarDetailListView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XdollarDetailCell.h"
#import "MJRefresh.h"

@class XdollarDetailListView;
typedef void (^XdollarDetailListViewLoadmoreBlock)(XdollarDetailListView *view);

@interface XdollarDetailListView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray <XdollarModel *>*dataArray;
@property (nonatomic, strong)XdollarDetailListViewLoadmoreBlock block;

@property (nonatomic, strong, readonly)MJRefreshAutoStateFooter *footer;


- (void)addXdollarDetailListViewLoadmoreBlock:(XdollarDetailListViewLoadmoreBlock)block;

@end
