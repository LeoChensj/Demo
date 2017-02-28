//
//  ActivityCollectionView.h
//  xbed
//
//  Created by Leo.Chen on 2016/11/10.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityCollectionViewCell.h"

typedef void (^ActivityCollectionViewSelectItemBlock)(ActivityContentsModel *model, NSInteger index);

@interface ActivityCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSArray <ActivityContentsModel *>*dataArray;
@property (nonatomic, strong)ActivityContentsModel *selectActivity;//选择的活动
@property (nonatomic, strong)ActivityCollectionViewSelectItemBlock block;


- (void)addActivityCollectionViewSelectItemBlock:(ActivityCollectionViewSelectItemBlock)block;

@end
