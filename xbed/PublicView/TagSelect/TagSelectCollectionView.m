//
//  TagSelectCollectionView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "TagSelectCollectionView.h"

@implementation TagSelectCollectionView

@synthesize myHeight = _myHeight;

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    if(self = [super initWithFrame:CGRectZero collectionViewLayout:layout])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.scrollsToTop = NO;
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        
        //注册CollectionViewCell与reusableView
        [self registerClass:[TagSelectCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
    return self;
}

- (void)setDataArray:(NSArray<TagModel *> *)dataArray
{
    _dataArray = dataArray;
    
    self.tags = nil;
    
    [self reloadData];
}

- (void)addTagSelectCollectionViewReloadCompleteBlock:(TagSelectCollectionViewReloadCompleteBlock)block
{
    _blockReloadComplete = block;
}




#pragma mark - UICollection DelegateFlowLayout DataSource Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = _dataArray[indexPath.row].name;
    
    NSDictionary *attribute = @{NSFontAttributeName : Font(12)};
    CGSize size = [content boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH, CGFLOAT_MAX)
                                          options:NSStringDrawingTruncatesLastVisibleLine |
                                                  NSStringDrawingUsesLineFragmentOrigin |
                                                  NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    return CGSizeMake(size.width+24, 24);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 10, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
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
    TagSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    
    if(self.allowsSelection)
    {
        cell.states = 0;
    }
    else//collectionView不能点击，cell默认蓝色
    {
        cell.states = 1;
    }
    
    
    if(indexPath.row==0)//待优化
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            _myHeight = self.contentSize.height;
            make.height.mas_equalTo(_myHeight);
            
        }];
    }
    
    if(indexPath.row==_dataArray.count-1 && _blockReloadComplete)
    {
        _blockReloadComplete();
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TagSelectCell *cell = (TagSelectCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.states = (cell.states+1)%2;
    
    
    if(cell.states==0)
    {
        [self removeTagsWithModel:_dataArray[indexPath.row]];
    }
    else if(cell.states==1)
    {
        [self addTagsWithModel:_dataArray[indexPath.row]];
    }
    
}


- (void)setAllowsSelection:(BOOL)allowsSelection
{
    [super setAllowsSelection:allowsSelection];
    
    if(_dataArray && _dataArray.count)
    {
        [self reloadData];
    }
}




#pragma mark - Helper
- (void)addTagsWithModel:(TagModel *)model
{
    NSMutableArray <NSNumber *>*tags = [NSMutableArray arrayWithArray:_tags];
    
    BOOL flag = NO;
    for (NSInteger i=0;i<tags.count;i++)
    {
        if([tags[i] isEqual:model.code])
        {
            flag = YES;
        }
    }
    
    
    if(!flag)
    {
        [tags addObject:model.code];
        self.tags = tags;
    }
}

- (void)removeTagsWithModel:(TagModel *)model
{
    NSMutableArray <NSNumber *>*tags = [NSMutableArray arrayWithArray:_tags];
    
    for (NSInteger i=0;i<tags.count;i++)
    {
        if([tags[i] isEqual:model.code])
        {
            [tags removeObjectAtIndex:i];
            self.tags = tags;
            break;
        }
    }
}






@end
