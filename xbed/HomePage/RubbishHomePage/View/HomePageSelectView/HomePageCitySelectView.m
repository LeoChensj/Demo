//
//  HomePageCitySelectView.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/13.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomePageCitySelectView.h"

@implementation HomePageCitySelectView

- (instancetype)init
{
    if(self = [super init])
    {
        self.normalColor = [UIColor whiteColor];
        self.touchColor = [UIColor whiteColor];
        
        _lbCity = [[UILabel alloc] init];
        _lbCity.textColor = Main_Text_Color;
        _lbCity.font = Font(14);
        [self addSubview:_lbCity];
        [_lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            
        }];
        
        UIImageView *imgvArr = [[UIImageView alloc] init];
        imgvArr.image = [UIImage imageNamed:@"ic_details_right_blue"];
        [self addSubview:imgvArr];
        [imgvArr mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(14);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
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

- (void)setCity:(NSString *)city
{
    _city = city;
    
    _lbCity.text = city;
}

@end
