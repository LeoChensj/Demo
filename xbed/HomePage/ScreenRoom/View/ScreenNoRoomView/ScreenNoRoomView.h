//
//  ScreenNoRoomView.h
//  xbed
//
//  Created by Leo.Chen on 2016/12/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScreenNoRoomCollectionView.h"

@interface ScreenNoRoomView : UIView
{
@private
    ScreenNoRoomCollectionView *_collectionView;
}

@property (nonatomic, strong)NSArray <ScreenRoomTagModel *>*dataArray;

- (void)addScreenNoRoomCollectionViewDeleteBlock:(ScreenNoRoomCollectionViewDeleteBlock)block;

@end
