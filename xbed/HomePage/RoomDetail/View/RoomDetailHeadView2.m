//
//  RoomDetailHeadView2.m
//  xbed
//
//  Created by Leo.Chen on 16/8/3.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailHeadView2.h"

@implementation RoomDetailHeadView2

- (instancetype)init
{
    if(self = [super init])
    {
        self.imgLeft = @"ic_back";
        self.imgRight = @"ic_share_slide";
        self.sizeRight = CGSizeMake(20, 19);
        
        _collectionView = [[CollectionView alloc] init];
        _collectionView.normalImage = @"ic_collection_slide";
        _collectionView.collectionImage = @"ic_collection";
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(34);
            make.height.mas_equalTo(32);
            make.right.mas_equalTo(-45);
            make.top.mas_equalTo(26);
            
        }];
    }
    
    return self;
}

@end
