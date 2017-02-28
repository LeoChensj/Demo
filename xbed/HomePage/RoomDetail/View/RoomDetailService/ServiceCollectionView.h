//
//  ServiceCollectionView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceCell.h"

@interface ServiceCollectionView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSArray <NSString *>*dataArray;    //显示全部，可滚动
@property (nonatomic, strong)NSArray <NSString *>*dataArray2;   //最多显示3行，不可滚动

@end
