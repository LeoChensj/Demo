//
//  PositionTableView1.m
//  xbed
//
//  Created by Leo.Chen on 16/7/23.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "PositionTableView1.h"

@implementation PositionTableView1

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 49;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

- (void)addPositionTableView1SelectBlock:(PositionTableView1SelectBlock)block
{
    _block = block;
}



#pragma - TableView DataSourse Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    PositionCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[PositionCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.model = _dataArray[indexPath.row];
    
    if([_dataArray[indexPath.row].code isEqual:_code])
    {
        cell.state = 1;
    }
    else
    {
        cell.state = 0;
    }
    
    return cell;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(PositionCell1 *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.model = _dataArray[indexPath.row];
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deselectRowAtIndexPath:indexPath animated:NO];//取消选中状态
    
    self.code = _dataArray[indexPath.row].code;
    
    if(_block)
    {
        _block(self, _dataArray[indexPath.row], indexPath);
    }
}



#pragma mark - setDataArray
- (void)setDataArray:(NSArray<ScreenRoomTagModel *> *)dataArray
{
    _dataArray = dataArray;
    
    self.code = _dataArray[0].code;
}

#pragma mark - setCode
- (void)setCode:(NSString *)code
{
    _code = code;
    
    [self reloadData];
}





@end
