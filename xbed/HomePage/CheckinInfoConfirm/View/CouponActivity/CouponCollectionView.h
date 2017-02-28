//
//  CouponCollectionView.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchEventCollectionView.h"
#import "CouponCollectionHeaderView.h"
#import "CouponCollectionViewCell.h"

typedef void (^CouponCollectionViewSelectItemBlock)(CouponCardModel *model, NSInteger index);

@interface CouponCollectionView : TouchEventCollectionView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign)BOOL allowSelect;
@property (nonatomic, strong)NSString *headTitle;
@property (nonatomic, strong)NSArray <NSArray <CouponCardModel *>*>*dataArray;
@property (nonatomic, strong)CouponCardModel *selectCoupon;//选择的优惠券
@property (nonatomic, strong)CouponCollectionViewSelectItemBlock block;


- (void)addCouponCollectionViewSelectItemBlock:(CouponCollectionViewSelectItemBlock)block;

@end
