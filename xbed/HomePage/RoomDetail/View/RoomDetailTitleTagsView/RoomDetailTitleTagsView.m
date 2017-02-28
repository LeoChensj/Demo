//
//  RoomDetailTitleTagsView.m
//  xbed
//
//  Created by Leo.Chen on 16/8/4.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "RoomDetailTitleTagsView.h"
#import "RoomImagesView.h"

@implementation RoomDetailTitleTagsView

- (instancetype)initWithRentType:(NSInteger)rentType
{
    if(self = [super init])
    {
        self.rentType = rentType;
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.numberOfLines = 0;
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = FontBold(16);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            
        }];
        
        _lbLongRentRemind = [[UILabel alloc] init];
        _lbLongRentRemind.text = @"免费在住打扫2次，包水电费、网络费、物业费";
        _lbLongRentRemind.textColor = Blue_Color;
        _lbLongRentRemind.font = Font(12);
        [self addSubview:_lbLongRentRemind];
        
        if(rentType==0)//短租
        {
            _lbLongRentRemind.hidden = YES;
            [_lbLongRentRemind mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(0);
                make.height.mas_equalTo(0);
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(_lbTitle.mas_bottom).offset(0);
                
            }];
        }
        else//长租
        {
            _lbLongRentRemind.hidden = NO;
            [_lbLongRentRemind mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
                make.height.mas_equalTo(12);
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(_lbTitle.mas_bottom).offset(10);
                
            }];
        }
        
        _tagsView = [[RoomDetailTagCollectionView alloc] init];
        [self addSubview:_tagsView];
        [_tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(100);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(_lbLongRentRemind.mas_bottom).offset(0);
            
        }];
        
        
        
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = Seg_Line_Color;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
            
        }];
        
    }
    
    return self;
}


- (void)setTitle:(NSString *)title
{
    _lbTitle.text = title;
    
    if(title)
    {
        self.hidden = NO;
        
        CGSize sizeTitle = [_lbTitle labelSize:MAIN_SCREEN_WIDTH-30];
        _heightTitle = sizeTitle.height;
        
        [_lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(_heightTitle);
            
        }];
    }
    else
    {
        self.hidden = YES;
    }
}

- (void)setDataArray:(NSArray<NSString *> *)dataArray
{
    _dataArray = dataArray;
    
    _tagsView.dataArray = dataArray;
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(RoomImagesViewHeight);
        make.bottom.mas_equalTo(_tagsView.mas_bottom).offset(0);
        
    }];
}





@end
