//
//  RoomDetailHeadView1.m
//  xbed
//
//  Created by Leo.Chen on 16/8/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailHeadView1.h"

@implementation RoomDetailHeadView1

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.imgLeft = @"ic_back_slide";
        self.imgRight = @"ic_share";
        self.sizeRight = CGSizeMake(20, 19);
        
        _vLine.hidden = YES;
        
        _collectionView = [[CollectionView alloc] init];
        _collectionView.normalImage = @"ic_no_collection";
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
