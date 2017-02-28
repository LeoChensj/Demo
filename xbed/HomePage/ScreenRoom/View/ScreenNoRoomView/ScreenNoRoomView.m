//
//  ScreenNoRoomView.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenNoRoomView.h"

@implementation ScreenNoRoomView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.numberOfLines = 0;
        lbTitle.text = @"小床君遗憾地对您说：\n符合您需求的房都被订满，可查找其它房哦";
        lbTitle.lineSpace = 5;
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.textColor = Secondary_Text_Color;
        lbTitle.font = Font(13);
        [self addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(280);
            make.height.mas_equalTo(35);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(50);
            
        }];
        
        
        _collectionView  = [[ScreenNoRoomCollectionView alloc] init];
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-229);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(30);
            
        }];
    }
    
    return self;
}

- (void)setDataArray:(NSArray<ScreenRoomTagModel *> *)dataArray
{
    _dataArray = dataArray;
    
    _collectionView.dataArray = dataArray;
}

- (void)addScreenNoRoomCollectionViewDeleteBlock:(ScreenNoRoomCollectionViewDeleteBlock)block
{
    _collectionView.block = block;
}

@end
