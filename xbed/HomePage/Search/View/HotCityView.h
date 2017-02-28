//
//  HotCityView.h
//  xbed
//
//  Created by Leo.Chen on 16/7/18.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  热门城市

#import "TouchEventCollectionView.h"

@interface HotCityCell : UICollectionViewCell
{
@private
    UILabel *_lbTitle;
}

@property (nonatomic, strong)NSString *title;

@end


@class HotCityView;
typedef void (^HotCityViewDidSelectItemBlock)(HotCityView *hotCityView, NSString *model, NSIndexPath *indexPath);

@interface HotCityView : TouchEventCollectionView <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSArray <NSString *>*dataArray;
@property (nonatomic, strong)HotCityViewDidSelectItemBlock block;

- (void)addHotCityViewDidSelectItemBlock:(HotCityViewDidSelectItemBlock)block;

@end
