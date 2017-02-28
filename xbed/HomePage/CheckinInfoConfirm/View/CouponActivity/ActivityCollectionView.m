//
//  ActivityCollectionView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ActivityCollectionView.h"

@implementation ActivityCollectionView

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
        [self registerClass:[ActivityCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    
    return self;
}

- (void)addActivityCollectionViewSelectItemBlock:(ActivityCollectionViewSelectItemBlock)block
{
    self.block = block;
}




- (void)setDataArray:(NSArray<ActivityContentsModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}



#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(_dataArray)
    {
        return _dataArray.count;
    }
    
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = _dataArray[indexPath.row].describes;
    
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
    ActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.activityModel = _dataArray[indexPath.row];
    cell.btnRadio.tag = 200+indexPath.row;
    
    //选择按钮状态
    if(_selectActivity && [_selectActivity.activityId isEqualToNumber:_dataArray[indexPath.row].activityId])
    {
        cell.btnRadio.on = YES;
    }
    else
    {
        cell.btnRadio.on = NO;
    }
    
    
    WS(ws);
    [[cell.btnRadio rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(LeoRadioButton *x) {
        
        NSInteger index = x.tag-200;
        
        if(x.on)
        {
            ws.selectActivity = ws.dataArray[index];
        }
        else
        {
            ws.selectActivity = nil;
        }
        
        if(ws.block)
        {
            ws.block(ws.selectActivity, index);
        }
        
    }];
    
    
    
    
    return cell;
}




- (void)setSelectActivity:(ActivityContentsModel *)selectActivity
{
    _selectActivity = selectActivity;
    
    [self reloadData];
}


@end
