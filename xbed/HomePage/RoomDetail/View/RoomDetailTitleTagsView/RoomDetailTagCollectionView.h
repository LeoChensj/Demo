//
//  RoomDetailTagCollectionView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomDetailTagCell.h"

@interface RoomDetailTagCollectionView : UICollectionView <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSArray <NSString *>*dataArray;

@end
