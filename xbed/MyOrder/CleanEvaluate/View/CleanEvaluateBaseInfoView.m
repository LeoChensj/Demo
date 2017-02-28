//
//  CleanEvaluateBaseInfoView.m
//  xbed
//
//  Created by Leo.Chen on 16/10/19.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "CleanEvaluateBaseInfoView.h"

@implementation CleanEvaluateBaseInfoView

- (instancetype)init
{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _imgvHead = [[UIImageView alloc] init];
        _imgvHead.layer.masksToBounds = YES;
        _imgvHead.layer.cornerRadius = 36.5;
        [self addSubview:_imgvHead];
        [_imgvHead mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(73);
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(25);
            
        }];
        
        _lbName = [[UILabel alloc] init];
        _lbName.textColor = Main_Text_Color;
        _lbName.font = Font(14);
        [self addSubview:_lbName];
        [_lbName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(_imgvHead.mas_right).offset(15);
            make.bottom.mas_equalTo(_imgvHead.mas_centerY).mas_equalTo(-10);
            
        }];
        
        
        _scoreView = [[ScoreStarShowView alloc] init];
        [self addSubview:_scoreView];
        [_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(_scoreView.myWidth);
            make.height.mas_equalTo(_scoreView.myheight);
            make.left.mas_equalTo(_imgvHead.mas_right).offset(15);
            make.top.mas_equalTo(_imgvHead.mas_centerY).mas_equalTo(10);
            
        }];
        
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.bottom.mas_equalTo(0);
            
        }];
        
    }
    
    return self;
}

- (void)setHead:(NSString *)head
{
    _head = head;
    
    [_imgvHead sd_setImageWithURL:[NSURL URLWithString:head] placeholderImage:PlaceholderHead];
}
- (void)setName:(NSString *)name
{
    _name = name;
    
    _lbName.text = [NSString stringWithFormat:@"Xbed管家   %@", name];
}
- (void)setScore:(NSNumber *)score
{
    _score = score;
    
    if(score==nil)
    {
        _scoreView.hidden = YES;
    }
    else
    {
        _scoreView.hidden = NO;
        _scoreView.score = score;
    }
    
}


@end
