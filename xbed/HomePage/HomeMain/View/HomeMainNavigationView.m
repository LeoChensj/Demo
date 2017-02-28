//
//  HomeMainNavigationView.m
//  xbed
//
//  Created by Leo.Chen on 16/7/14.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomeMainNavigationView.h"

@implementation HomeMainNavigationView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = Blue_Color;
        
        _searchBar = [[TouchView alloc] init];
        _searchBar.normalColor = [UIColor whiteColor];
        _searchBar.touchColor = [UIColor whiteColor];
        _searchBar.layer.masksToBounds = YES;
        _searchBar.layer.cornerRadius = 15;
        [self addSubview:_searchBar];
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH-30);
            make.height.mas_equalTo(30);
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-8);
            
        }];
        
        
        _imgvIcon = [[UIImageView alloc] init];
        _imgvIcon.image = [UIImage imageNamed:@"ic_index_enlarge"];
        [_searchBar addSubview:_imgvIcon];
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(17);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.text = @"搜寻最适合你的房间";
        _lbTitle.textColor = Main_Text_Color;
        _lbTitle.font = Font(12);
        [_searchBar addSubview:_lbTitle];
        [_lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(_imgvIcon.mas_right).offset(15);
            make.centerY.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

@end
