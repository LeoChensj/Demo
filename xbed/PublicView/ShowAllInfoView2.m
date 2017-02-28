//
//  ShowAllInfoView2.m
//  xbed
//
//  Created by Leo.Chen on 16/8/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ShowAllInfoView2.h"

@implementation ShowAllInfoView2

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        _vContent = [[UIView alloc] init];
        _vContent.backgroundColor = [UIColor whiteColor];
        _vContent.layer.masksToBounds = YES;
        _vContent.layer.cornerRadius = 3;
        [self addSubview:_vContent];
        [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-150);
            make.center.mas_equalTo(0);
            
        }];
        
        
        _lbtitle = [[UILabel alloc] init];
        _lbtitle.text = @"配套设施及服务";
        _lbtitle.textColor = Main_Text_Color;
        _lbtitle.font = FontBold(18);
        [_vContent addSubview:_lbtitle];
        [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(20);
            
        }];
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = Main_Text_Color;
        [_vContent addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-60);
            make.height.mas_equalTo(1.5);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(_lbtitle.mas_bottom).offset(20);
            
        }];
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.sectionInset = UIEdgeInsetsMake(30, 15, 30, 15);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 30;
        layout.itemSize = CGSizeMake((MAIN_SCREEN_WIDTH-30-30)/3, 14);
        
        _collectionView = [[ServiceCollectionView alloc] init];
        _collectionView.alwaysBounceVertical = YES;
        [_vContent addSubview:_collectionView];
        [_collectionView setCollectionViewLayout:layout];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(MAIN_SCREEN_HEIGHT-150-60-49);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(line1.mas_bottom).offset(0);

            
        }];
        
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = Blue_Color;
        [_vContent addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-60);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-49);
            
        }];
        
        
        _btnClose = [[UIButton alloc] init];
        [_btnClose setTitle:@"我知道了" forState:UIControlStateNormal];
        [_btnClose setTitleColor:Blue_Color forState:UIControlStateNormal];
        _btnClose.titleLabel.font = Font(16);
        [_vContent addSubview:_btnClose];
        [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(49);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
        }];
        
        WS(ws);
        [[_btnClose rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [ws removeFromSuperview];
            
        }];
    }
    
    return self;
}

- (void)setDataArray:(NSArray<NSString *> *)dataArray
{
    _dataArray = dataArray;
    
    _collectionView.dataArray = dataArray;
}

@end
