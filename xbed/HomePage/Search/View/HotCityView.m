//
//  HotCityView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HotCityView.h"

@implementation HotCityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 14;
        self.layer.borderWidth = 1;
        self.layer.borderColor = Secondary_Text_Color2.CGColor;
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = Secondary_Text_Color;
        _lbTitle.font = Font(12);
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
            make.center.mas_equalTo(0);
            
        }];
        
        
        RAC(_lbTitle, text) = RACObserve(self, title);
        
    }
    
    return self;
}

@end




@implementation HotCityView

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
        [self registerClass:[HotCityCell class] forCellWithReuseIdentifier:@"cell"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    }
    
    return self;
}

- (void)setDataArray:(NSArray<NSString *> *)dataArray
{
    _dataArray = dataArray;
    
    if(_dataArray==nil || _dataArray.count==0)
    {
        self.hidden = YES;
    }
    else
    {
        self.hidden = NO;
        [self reloadData];
    }
}

- (void)addHotCityViewDidSelectItemBlock:(HotCityViewDidSelectItemBlock)block
{
    _block = block;
}



#pragma mark - UICollection DelegateFlowLayout DataSource Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = _dataArray[indexPath.row];
    
    return CGSizeMake((content.length*12+28), 28);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 20);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
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
    HotCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.title = _dataArray[indexPath.row];
    
    if(indexPath.row==0)//待优化
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            CGFloat height = self.contentSize.height;
            make.height.mas_equalTo(height);
            
        }];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(MAIN_SCREEN_WIDTH, 42);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
        headerView.backgroundColor = Background_Color;
        
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.textColor = Main_Text_Color;
        lbTitle.font = Font(14);
        lbTitle.text = @"热门城市";
        [headerView addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            
        }];
    }
    
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%@", _dataArray[indexPath.row]);
    if(_block)
    {
        _block(self, _dataArray[indexPath.row], indexPath);
    }
}





@end














