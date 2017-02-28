//
//  OrderListView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListHeaderView.h"
#import "OrderListCell.h"
#import "MJRefresh.h"

@class OrderListView;
typedef void (^OrderListViewSelectItemBlock)(OrderListView *view, CheckinOrderListModel *model, NSIndexPath *indexPath);
typedef void (^OrderListViewRefreshBlock)(MJRefreshNormalHeader *headerView);
typedef void (^OrderListViewLoadmoreBlock)(MJRefreshAutoStateFooter *footerView);

@interface OrderListView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray <OrderListContnetModel *>*dataArray;
@property (nonatomic, strong)OrderListViewSelectItemBlock selectBlock;
@property (nonatomic, strong)OrderListViewRefreshBlock refreshBlock;
@property (nonatomic, strong)OrderListViewLoadmoreBlock loadmoreBlock;

@property (nonatomic, strong, readonly)MJRefreshNormalHeader *header;
@property (nonatomic, strong, readonly)MJRefreshAutoStateFooter *footer;


- (void)addOrderListViewSelectItemBlock:(OrderListViewSelectItemBlock)selectBlock refreshBlock:(OrderListViewRefreshBlock)refreshBlock loadmoreBlock:(OrderListViewLoadmoreBlock)loadmoreBlock;

@end
