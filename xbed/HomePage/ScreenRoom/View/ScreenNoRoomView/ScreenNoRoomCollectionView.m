//
//  ScreenNoRoomCollectionView.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenNoRoomCollectionView.h"

@implementation ScreenNoRoomCollectionView

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    if(self = [super initWithFrame:CGRectZero collectionViewLayout:layout])
    {
        self.backgroundColor = Background_Color;
        self.scrollsToTop = NO;
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        
        
        //注册CollectionViewCell
        [self registerClass:[ScreenNoRoomCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
    return self;
}

- (void)setDataArray:(NSArray<ScreenRoomTagModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}




#pragma mark - UICollection DelegateFlowLayout DataSource Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = _dataArray[indexPath.row].cname;
    
    NSDictionary *attribute = @{NSFontAttributeName : Font(13)};
    CGSize labelSize = [content boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH-50, CGFLOAT_MAX)
                                               options:NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading
                                            attributes:attribute
                                               context:nil].size;
    
    return CGSizeMake((15+labelSize.width+10+15+15), 30);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

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
    ScreenNoRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.block)
    {
        self.block(_dataArray[indexPath.row], indexPath);
    }
}




@end
