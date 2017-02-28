//
//  CouponCollectionView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CouponCollectionView.h"

@implementation CouponCollectionView

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 15;
    
    if(self = [super initWithFrame:CGRectZero collectionViewLayout:layout])
    {
        self.backgroundColor = Background_Color;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceVertical = YES;
        self.dataSource = self;
        self.delegate = self;
        
        //注册CollectionViewCell与reusableView
        [self registerClass:[CouponCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self registerClass:[CouponCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    
    return self;
}

- (void)addCouponCollectionViewSelectItemBlock:(CouponCollectionViewSelectItemBlock)block
{
    self.block = block;
}



- (void)setDataArray:(NSArray<NSArray<CouponCardModel *> *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}




#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(_dataArray)
    {
        return _dataArray[section].count;
    }
    
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return CGSizeZero;
    }
    else
    {
        if(_dataArray.count>=2 && _dataArray[1].count>0)
            return CGSizeMake(MAIN_SCREEN_WIDTH, 20);
        else
            return CGSizeZero;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(kind == UICollectionElementKindSectionHeader)
    {
        NSString *headerIdentifier = @"header";
        
        CouponCollectionHeaderView *cell = (CouponCollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        cell.title = _headTitle;
        
        return cell;
    }
    
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = _dataArray[indexPath.section][indexPath.row].desc;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 5;
    NSDictionary *attribute = @{NSFontAttributeName : Font(13),
                                NSParagraphStyleAttributeName : paraStyle};
    
    CGSize labelSize = [content boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WIDTH-40, CGFLOAT_MAX)
                                               options:NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading
                                            attributes:attribute
                                               context:nil].size;
    
    CGFloat height = labelSize.height+98;
    if(height<150) height = 150;
    
    return CGSizeMake(MAIN_SCREEN_WIDTH-20, height);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CouponCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.couponModel = _dataArray[indexPath.section][indexPath.row];
    cell.allowsSelection = _allowSelect;
    cell.btnRadio.tag = 100+indexPath.row;
    
    
    //选择按钮状态
    if(_selectCoupon && [_selectCoupon.code isEqualToString:_dataArray[indexPath.section][indexPath.row].code])
    {
        cell.btnRadio.on = YES;
    }
    else
    {
        cell.btnRadio.on = NO;
    }
    
    
    //卡片状态
    if(indexPath.section==0)
    {
        cell.enable = YES;
    }
    else
    {
        cell.enable = NO;
    }
    
    
    
    WS(ws);
    [[cell.btnRadio rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(LeoRadioButton *x) {
        
        NSInteger index = x.tag-100;
        
        if(x.on)
        {
            ws.selectCoupon = ws.dataArray[0][index];
        }
        else
        {
            ws.selectCoupon = nil;
        }
        
        if(ws.block)
        {
            ws.block(ws.selectCoupon, index);
        }
        
    }];
    
    
    return cell;
}



- (void)setSelectCoupon:(CouponCardModel *)selectCoupon
{
    _selectCoupon = selectCoupon;
    
    [self reloadData];
}


@end
