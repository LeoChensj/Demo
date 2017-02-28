//
//  RoomEvaluateListTagsView.m
//  xbed
//
//  Created by Leo.Chen on 2017/2/13.
//  Copyright © 2017年 Leo.Chen. All rights reserved.
//

#import "RoomEvaluateListTagsView.h"

@implementation RoomEvaluateListTagsView

- (void)setDataArray:(NSArray<NSString *> *)dataArray
{
    [super setDataArray:dataArray];
    
    if(dataArray==nil || dataArray.count==0)
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0);
            
        }];
        
        self.hidden = YES;
    }
    else
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(100);
            
        }];
        
        self.hidden = NO;
        [self reloadData];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 10, 0);
}

@end
