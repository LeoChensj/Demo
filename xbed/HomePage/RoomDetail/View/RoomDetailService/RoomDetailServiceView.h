//
//  RoomDetailServiceView.h
//  xbed
//
//  Created by Leo.Chen on 16/8/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceCollectionView.h"

@interface RoomDetailServiceView : UIView
{
@private
    UILabel *_lbTitle;
    ServiceCollectionView *_collectionView;
}

@property (nonatomic, strong, readonly)UIButton *btnAll;
@property (nonatomic, strong)NSArray <NSString *>*dataArray;

@end
