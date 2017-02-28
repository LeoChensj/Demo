//
//  ServiceCollectionView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ServiceCollectionView.h"

@implementation ServiceCollectionView

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 30;
    layout.itemSize = CGSizeMake((MAIN_SCREEN_WIDTH-30)/3, 14);
    
    if(self = [super initWithFrame:CGRectZero collectionViewLayout:layout])
    {
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        
        //注册CollectionViewCell与reusableView
        [self registerClass:[ServiceCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
    return self;
}

- (void)setDataArray:(NSArray<NSString *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}

- (void)setDataArray2:(NSArray<NSString *> *)dataArray2
{
    _dataArray2 = dataArray2;
    
    NSArray *dataArray;
    if(_dataArray2.count>9)
    {
        dataArray = [_dataArray2 subarrayWithRange:NSMakeRange(0, 9)];
    }
    else
    {
        dataArray = _dataArray2;
    }
    
    NSInteger allRow = dataArray.count/3+(dataArray.count%3 ? 1 : 0);   //总的行数
    CGFloat height = allRow*14+(allRow-1)*30;
    if(height<0) height = 0;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(height);
        
    }];
    
    self.dataArray = dataArray;
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
    ServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.title = _dataArray[indexPath.row];
    
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


@end


