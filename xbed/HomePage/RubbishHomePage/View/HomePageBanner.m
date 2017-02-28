//
//  HomePageBanner.m
//  xbed
//
//  Created by Leo.Chen on 2016/11/11.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "HomePageBanner.h"

@implementation HomePageBanner

- (instancetype)init
{
    if(self = [super initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_WIDTH*324/375)])
    {
        self.backgroundColor = Background_Color;
        self.interval = 4;
        self.navigation = [RootViewController getInstance];
        self.placeholderImage = PlaceholderImage;
        
        UIImageView *imgvLogo = [[UIImageView alloc] init];
        imgvLogo.image = [UIImage imageNamed:@"ic_logo"];
        [self addSubview:imgvLogo];
        [imgvLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(57);
            make.height.mas_equalTo(22);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
    }
    
    return self;
}

@end
