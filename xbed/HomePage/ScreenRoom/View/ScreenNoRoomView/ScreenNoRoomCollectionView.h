//
//  ScreenNoRoomCollectionView.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenNoRoomCell.h"

typedef void(^ScreenNoRoomCollectionViewDeleteBlock)(ScreenRoomTagModel *model, NSIndexPath *indexPath);

@interface ScreenNoRoomCollectionView : UICollectionView <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*dataArray;
@property (nonatomic, strong)ScreenNoRoomCollectionViewDeleteBlock block;


@end
