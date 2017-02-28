//
//  CollectionView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/20.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  收藏按钮

#import "TouchView.h"

@class CollectionView;
typedef void (^CollectionViewTouchBlock)(CollectionView *view, BOOL flag);//flag:YES收藏，NO取消收藏

@interface CollectionView : TouchView

@property (nonatomic, strong, readonly)UIImageView *imgvIcon;
@property (nonatomic, assign)BOOL flag;//标识是否在延时中

@property (nonatomic, strong)NSString *normalImage;
@property (nonatomic, strong)NSString *collectionImage;
@property (nonatomic, assign)NSInteger states;//0：未收藏；  1:已收藏
@property (nonatomic, strong)CollectionViewTouchBlock block;


- (void)addCollectionViewTouchBlock:(CollectionViewTouchBlock)block;
- (void)changeStatesWithAnimate:(BOOL)animate;

@end
