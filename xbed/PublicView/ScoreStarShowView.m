//
//  ScoreStarShowView.m
//  xbed
//
//  Created by Leo.Chen on 16/10/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScoreStarShowView.h"

@implementation ScoreStarShowView

- (instancetype)init
{
    if(self = [super init])
    {
        _stars = [NSMutableArray array];
        
        for (NSInteger i=0;i<5;i++)
        {
            UIImageView *imgvStar = [[UIImageView alloc] init];
            [self addSubview:imgvStar];
            [imgvStar mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.width.height.mas_equalTo(12);
                make.centerY.mas_equalTo(0);
                make.left.mas_equalTo(19*i);
                
            }];
            
            [_stars addObject:imgvStar];
        }
        
        
        _lbScore = [[UILabel alloc] init];
        _lbScore.textColor = Orange_Color;
        _lbScore.font = Font(12);
        [self addSubview:_lbScore];
        [_lbScore mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(_stars.lastObject.mas_right).offset(10);
            make.centerY.mas_equalTo(0);
            
        }];
        
        
        _myWidth = 19*5-7+10+40;
        _myheight = 12;
    }
    
    return self;
}

- (void)setScore:(NSNumber *)score
{
    _score = score;
    
    NSInteger value_10 = score.floatValue*10;
    
    NSInteger valueFull = value_10/10;
    BOOL isHalf = value_10%10>0 ? YES : NO;
    
    for (NSInteger i=0;i<5;i++)
    {
        if(i<=(valueFull-1))//满星
        {
            _stars[i].image = [UIImage imageNamed:@"ic_start_small"];
        }
        else if(i==valueFull)//半星
        {
            if(isHalf)
            {
                _stars[i].image = [UIImage imageNamed:@"ic_half_start"];
            }
            else
            {
                _stars[i].image = [UIImage imageNamed:@"ic_start_small_gray"];
            }
        }
        else
        {
            _stars[i].image = [UIImage imageNamed:@"ic_start_small_gray"];
        }
    }
    
    _lbScore.text = [NSString stringWithFormat:@"%@分", score];
}





@end
