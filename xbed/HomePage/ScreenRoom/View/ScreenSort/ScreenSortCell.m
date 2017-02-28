//
//  ScreenSortCell.m
//  xbed
//
//  Created by Leo.Chen on 16/7/27.
//  Copyright © 2016年 Leo.Chen. All rights reserved.
//

#import "ScreenSortCell.h"

@implementation ScreenSortCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.titleLabel.font = Font(12);
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = Seg_Line_Color;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(LINE_WIDTH);
            make.left.top.mas_equalTo(0);
            
        }];
    }
    
    return self;
}

- (void)setModel:(ScreenRoomTagModel *)model
{
    _model = model;
    
    [self setTitle:model.cname forState:UIControlStateNormal];
}

- (void)setStates:(NSInteger)states
{
    _states = states;
    
    if(states==0)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:Main_Text_Color forState:UIControlStateNormal];
    }
    else if(states==1)
    {
        self.backgroundColor = Background_Color;
        [self setTitleColor:Blue_Color forState:UIControlStateNormal];
    }
}




@end
