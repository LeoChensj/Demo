//
//  CollectRoomListView.m
//  xbed
//
//  Created by Leo.Chen on 16/9/29.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CollectRoomListView.h"

@implementation CollectRoomListView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = RoomListCellHeight;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.contentInset = UIEdgeInsetsMake(0, 0, TABBAR_HEIGHT+10, 0);
        self.showsVerticalScrollIndicator = NO;
        
        
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
            
            if(ws.loadMoreBlock)
            {
                ws.loadMoreBlock(ws.footer);
            }
            
        }];
        _footer.stateLabel.textColor = Secondary_Text_Color2;
        [_footer setTitle:@"加载更多..." forState:MJRefreshStateRefreshing];
        [_footer setTitle:@"" forState:MJRefreshStateIdle];
        self.mj_footer = _footer;
    }
    
    return self;
}

- (void)setDataArray:(NSArray<CollectRoomListModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}
- (void)addRoomListViewDidSelectItemBlock:(CollectRoomListViewDidSelectItemBlock)selectItemBlock refreshBlock:(CollectRoomListViewRefreshBlock)refreshBlock loadmoreBlock:(CollectRoomListViewLoadmoreBlock)loadMoreBlock collection:(CollectRoomCellCollectionTouchBlock)collectionBlock off:(CollectRoomCellRoomOffBlock)offBlock
{
    _selectItemBlock = selectItemBlock;
    _refreshBlock = refreshBlock;
    _loadMoreBlock = loadMoreBlock;
    _collectionBlock = collectionBlock;
    _offBlock = offBlock;
}




#pragma - TableView DataSourse Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    CollectRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[CollectRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(CollectRoomCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = _dataArray[indexPath.row];
    
    [cell addCollectRoomCellCollectionTouchBlock:_collectionBlock collectRoomCellRoomOffBlock:_offBlock];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAtIndexPath:indexPath animated:NO];//取消选中状态
    
    //下架的不能点
    if(_dataArray[indexPath.row].flag.integerValue==1)
    {
        if(_selectItemBlock)
        {
            _selectItemBlock(self, _dataArray[indexPath.row], indexPath);
        }
    }
}




@end
