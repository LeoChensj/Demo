//
//  RoomListView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomListView.h"

@implementation RoomListView

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(RoomListCellWidth, RoomListCellHeight);
    
    if(self = [super initWithFrame:CGRectZero collectionViewLayout:layout])
    {
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        
        //注册CollectionViewCell与reusableView
        [self registerClass:[RoomListCell class] forCellWithReuseIdentifier:@"cell"];
        
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
        
        
        //---loadmore------//
        _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            if(ws.loadMoreBlock)
            {
                ws.loadMoreBlock(ws.footer);
            }
            
        }];
        _footer.stateLabel.textColor = Secondary_Text_Color2;
        [_footer setTitle:@"加载更多..." forState:MJRefreshStateRefreshing];
        [_footer setTitle:@"" forState:MJRefreshStateIdle];
        self.mj_footer = _footer;
        //---loadmore------//
        
    }
    
    return self;
}

- (void)setDataArray:(NSArray<ScreenRoomListModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}

- (void)addRoomListViewRefreshBlock:(RoomListViewRefreshBlock)refreshBlock didSelectItemBlock:(RoomListViewDidSelectItemBlock)selectItemBlock loadmoreBlock:(RoomListViewLoadmoreBlock)loadMoreBlock collection:(RoomListCellCollectionTouchBlock)collectionBlock
{
    _refreshBlock = refreshBlock;
    _selectItemBlock = selectItemBlock;
    _loadMoreBlock = loadMoreBlock;
    _collectionBlock = collectionBlock;
}





#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(_dataArray)
        return _dataArray.count;
    else
        return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    RoomListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    
    [cell addRoomListCellCollectionTouchBlock:_collectionBlock];
    
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_selectItemBlock)
    {
        _selectItemBlock(self, _dataArray[indexPath.row], indexPath);
    }
}


@end



