//
//  TagSelectCollectionView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagSelectCell.h"

@class TagSelectCollectionView;
typedef void (^TagSelectCollectionViewReloadCompleteBlock)();

@interface TagSelectCollectionView : UICollectionView <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSArray <TagModel *>*dataArray;
@property (nonatomic, strong)NSArray <NSNumber *>*tags;//选择的tag
@property (nonatomic, strong)TagSelectCollectionViewReloadCompleteBlock blockReloadComplete;

@property (nonatomic, assign, readonly)CGFloat myHeight;


- (void)addTagSelectCollectionViewReloadCompleteBlock:(TagSelectCollectionViewReloadCompleteBlock)block;

@end
