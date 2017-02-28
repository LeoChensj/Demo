//
//  EvaluateOverdueStarView.m
//  xbed
//
//  Created by Leo.Chen on 2016/12/22.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "EvaluateOverdueStarView.h"

@implementation EvaluateOverdueStarView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"评价已过期";
        lbTitle.textColor = Secondary_Text_Color2;
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.font = Font(16);
        [self addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(16);
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(30);
            
        }];
        
        UILabel *lbTitleRoom = [[UILabel alloc] init];
        lbTitleRoom.text = @"房间评分";
        lbTitleRoom.textColor = Secondary_Text_Color2;
        lbTitleRoom.font = Font(14);
        [self addSubview:lbTitleRoom];
        [lbTitleRoom mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(lbTitle.mas_bottom).offset(25);
            
        }];
        
        UILabel *lbTitleClean = [[UILabel alloc] init];
        lbTitleClean.text = @"清洁评分";
        lbTitleClean.textColor = Secondary_Text_Color2;
        lbTitleClean.font = Font(14);
        [self addSubview:lbTitleClean];
        [lbTitleClean mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(lbTitleRoom.mas_bottom).offset(25);
            
        }];
        
        
        for (NSInteger i=0;i<5;i++)
        {
            UIImageView *imgvStar = [[UIImageView alloc] init];
            imgvStar.image = [UIImage imageNamed:@"ic_start_gray"];
            [self addSubview:imgvStar];
            [imgvStar mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.height.mas_equalTo(28);
                make.centerY.mas_equalTo(lbTitleRoom.mas_centerY).offset(0);
                make.left.mas_equalTo(93+40*i);
                
            }];
        }
        
        for (NSInteger i=0;i<5;i++)
        {
            UIImageView *imgvStar = [[UIImageView alloc] init];
            imgvStar.image = [UIImage imageNamed:@"ic_start_gray"];
            [self addSubview:imgvStar];
            [imgvStar mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.height.mas_equalTo(28);
                make.centerY.mas_equalTo(lbTitleClean.mas_centerY).offset(0);
                make.left.mas_equalTo(93+40*i);
                
            }];
        }
        
    }
    
    return self;
}

@end
