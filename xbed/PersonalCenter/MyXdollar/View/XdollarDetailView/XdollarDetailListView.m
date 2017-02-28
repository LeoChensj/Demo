//
//  XdollarDetailListView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/25.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "XdollarDetailListView.h"

@implementation XdollarDetailListView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 55;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.contentInset = UIEdgeInsetsMake(15, 0, 10, 0);
        self.allowsSelection = NO;
        
        
        WS(ws);
        _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            if(ws.block)
            {
                ws.block(ws);
            }
            
        }];
        _footer.stateLabel.textColor = Secondary_Text_Color2;
        [_footer setTitle:@"加载更多..." forState:MJRefreshStateRefreshing];
        [_footer setTitle:@"" forState:MJRefreshStateIdle];
        self.mj_footer = _footer;
        
    }
    
    return self;
}

- (void)addXdollarDetailListViewLoadmoreBlock:(XdollarDetailListViewLoadmoreBlock)block
{
    _block = block;
}

- (void)setDataArray:(NSArray<XdollarModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}


#pragma - TableView DataSourse Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    XdollarDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[XdollarDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(XdollarDetailCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.model = _dataArray[indexPath.row];
}



@end
