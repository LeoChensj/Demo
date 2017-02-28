//
//  HomePageSearchView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomePageSearchView.h"

@implementation HomePageSearchView

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"搜索目的地、商圈";
        _lbTitle.textColor = Secondary_Text_Color2;
        _lbTitle.font = Font(14);
        [self addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-100);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _imgvArr = [[UIImageView alloc] init];
        _imgvArr.image = [UIImage imageNamed:@"ic_details_right_blue"];
        [self addSubview:_imgvArr];
        [_imgvArr mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(0);
            
        }];
        
        _imgvClear = [[UIImageView alloc] init];
        _imgvClear.image = [UIImage imageNamed:@"ic_search_delete"];
        [self addSubview:_imgvClear];
        [_imgvClear mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(14);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-20);
            
        }];
        _imgvClear.hidden = YES;
        
        _btnClear = [[UIButton alloc] init];
        [self addSubview:_btnClear];
        [_btnClear mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(50);
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        _btnClear.enabled = NO;

        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-20-30);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(0);
            
        }];
        
        
    }
    
    return self;
}


- (void)setModel:(SearchModel *)model
{
    _model = model;
    
    if(model)
    {
        _lbTitle.text = model.cname;
        _lbTitle.textColor = Main_Text_Color;
        _imgvClear.hidden = NO;
        _imgvArr.hidden = YES;
        _btnClear.enabled = YES;
    }
    else
    {
        _lbTitle.text = @"搜索区域、楼宇、商圈";
        _lbTitle.textColor = Secondary_Text_Color2;
        _imgvClear.hidden = YES;
        _imgvArr.hidden = NO;
        _btnClear.enabled = NO;
    }
}

@end
