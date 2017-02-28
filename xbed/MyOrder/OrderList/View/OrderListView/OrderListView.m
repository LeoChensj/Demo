//
//  OrderListView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "OrderListView.h"
#import "OrderWordShowView.h"

@implementation OrderListView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.contentInset = UIEdgeInsetsMake(0, 0, TABBAR_HEIGHT+10, 0);
        
        
        WS(ws);
        _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            NSLog(@"刷新");
            
            if(ws.refreshBlock)
            {
                ws.refreshBlock(ws.header);
            }
            
        }];
        _header.stateLabel.textColor = Secondary_Text_Color2;
        _header.lastUpdatedTimeLabel.textColor = Secondary_Text_Color2;
        self.mj_header = _header;
        
        
        _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            NSLog(@"加载更多");
            
            if(ws.loadmoreBlock)
            {
                ws.loadmoreBlock(ws.footer);
            }
            
        }];
        _footer.stateLabel.textColor = Secondary_Text_Color2;
        [_footer setTitle:@"加载更多..." forState:MJRefreshStateRefreshing];
        [_footer setTitle:@"" forState:MJRefreshStateIdle];
        self.mj_footer = _footer;

    }
    
    return self;
}

- (void)setDataArray:(NSArray<OrderListContnetModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}
- (void)addOrderListViewSelectItemBlock:(OrderListViewSelectItemBlock)selectBlock refreshBlock:(OrderListViewRefreshBlock)refreshBlock loadmoreBlock:(OrderListViewLoadmoreBlock)loadmoreBlock
{
    _selectBlock = selectBlock;
    _refreshBlock = refreshBlock;
    _loadmoreBlock = loadmoreBlock;
}


#pragma - TableView DataSourse Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray[section].checkinOrderList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10+34;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_dataArray[indexPath.section].checkinOrderList[indexPath.row].commandState.integerValue==1)
    {
        return 110+44;
    }
    
    return 110;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headIdentifier = @"head";
    OrderListHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    
    if(headView==nil)
    {
        headView = [[OrderListHeaderView alloc] initWithReuseIdentifier:headIdentifier];
    }

    return headView;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(OrderListHeaderView *)view forSection:(NSInteger)section
{
    view.tintColor = Background_Color;
    view.title = _dataArray[section].checkinOrderList[0].roomInfo.custRoomName;
    view.state = _dataArray[section].type;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(OrderListCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = _dataArray[indexPath.section].checkinOrderList[indexPath.row];
    
    //WS(ws);
    [cell addOrderListCellGetWordBlock:^(CheckinOrderListModel *model) {
        
        NSLog(@"口令：%@", model.command);
        
        OrderWordShowView *wordView = [[OrderWordShowView alloc] initWithType:0];
        wordView.word = model.command;
        wordView.name = model.commandName;
        wordView.phone = model.commandPhone;
        [[UIApplication sharedApplication].keyWindow addSubview:wordView];
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(_selectBlock)
    {
        _selectBlock(self, _dataArray[indexPath.section].checkinOrderList[indexPath.row], indexPath);
    }
}


//取消表头悬停
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //去掉UItableview的section的headerview黏性
    CGFloat sectionHeaderHeight = 10+34;
    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, TABBAR_HEIGHT+10+30, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, TABBAR_HEIGHT+10+30, 0);
    }
}



@end
