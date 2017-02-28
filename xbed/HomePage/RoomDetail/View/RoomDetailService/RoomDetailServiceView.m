//
//  RoomDetailServiceView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/8.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailServiceView.h"

@implementation RoomDetailServiceView

@synthesize btnAll = _btnAll;

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Background_Color;
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"配套设施及服务";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.textAlignment = NSTextAlignmentCenter;
        _lbTitle.font = FontBold(16);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(16);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
        
        
        
        _collectionView = [[ServiceCollectionView alloc] init];
        _collectionView.scrollEnabled = NO;
        [self addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(100);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_lbTitle.mas_bottom).offset(20);
            
        }];

    }
    
    return self;
}


- (UIButton *)btnAll
{
    if(_btnAll==nil)
    {
        _btnAll = [[UIButton alloc] init];
        _btnAll.layer.masksToBounds = YES;
        _btnAll.layer.cornerRadius = 2;
        _btnAll.layer.borderColor = Blue_Color.CGColor;
        _btnAll.layer.borderWidth = LINE_WIDTH;
        [_btnAll setTitle:@"查看全部" forState:UIControlStateNormal];
        [_btnAll setTitleColor:Blue_Color forState:UIControlStateNormal];
        _btnAll.titleLabel.font = Font(12);
        [self addSubview:_btnAll];
        [_btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(34);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(_collectionView.mas_bottom).offset(30);
            
        }];
    }
    
    return _btnAll;
}


- (void)setDataArray:(NSArray<NSString *> *)dataArray
{
    _dataArray = dataArray;
    
    if(dataArray)
    {
        self.hidden = NO;
        _collectionView.dataArray2 = dataArray;
    }
    else
    {
        self.hidden = YES;
    }
}






@end
