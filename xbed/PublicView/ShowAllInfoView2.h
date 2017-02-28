//
//  ShowAllInfoView2.h
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//  配套设施及服务 查看全部

#import <UIKit/UIKit.h>
#import "ServiceCollectionView.h"

@interface ShowAllInfoView2 : UIView
{
@private
    UIView *_vContent;
    UILabel *_lbtitle;
    ServiceCollectionView *_collectionView;
    UIButton *_btnClose;
}

@property (nonatomic, strong)NSArray <NSString *>*dataArray;

@end
